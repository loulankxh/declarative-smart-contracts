package verification

import com.microsoft.z3.{ArrayExpr, BoolExpr, Context, Expr, IntSort, Sort, Status, TupleSort}
import datalog.{Constant, Parameter, Program, Relation, ReservedRelation, Rule, SimpleRelation, SingletonRelation, Type, Variable}
import imp.SolidityTranslator.transactionRelationPrefix
import imp.Translator.getMaterializedRelations
import imp.{AbstractImperativeTranslator, DeleteTuple, ImperativeAbstractProgram, IncrementValue, InsertTuple, ReplacedByKey, Trigger}
import verification.Prove.{get_vars, prove}
import verification.RuleZ3Constraints.getVersionedVariableName
import verification.TransitionSystem.makeStateVar
import verification.Z3Helper.{addressSize, extractEq, functorToZ3, getArraySort, getSort, initValue, literalToConst, makeTupleSort, paramToConst, relToTupleName, typeToSort, uintSize}
import view.{CountView, JoinView, MaxView, SumView, View}

case class RuleZ3Constraints(ruleConstraints: BoolExpr,
                             updateConstraint: BoolExpr,
                             updateExprs: Array[(Expr[Sort], Expr[Sort], Expr[_<:Sort])],
                             nextTriggers: Set[Trigger]) {
  def allConstraints(ctx: Context): BoolExpr = ctx.mkAnd(ruleConstraints, updateConstraint)

  def getVersionedUpdateConstraint(ctx: Context, relation: Relation, indices: List[Int], version: Int): BoolExpr = {
    if (updateExprs.nonEmpty) {
      val allUpdates = {
        val _exprs: Array[BoolExpr] = updateExprs.map(t => ctx.mkEq(t._2, t._3))
        ctx.mkAnd(_exprs:_*)
      }
      val versionedUpdates: BoolExpr = versionUpdateExpr(ctx, allUpdates, relation, indices, version).asInstanceOf[BoolExpr]
      ctx.mkAnd(updateConstraint, versionedUpdates)
    }
    else {
      ctx.mkAnd(updateConstraint).simplify().asInstanceOf[BoolExpr]
    }
  }

  private def versionUpdateExpr(ctx: Context, expr: Expr[_], relation: Relation, indices: List[Int], version: Int): Expr[_] = {
    val sort = getSort(ctx, relation, indices)
    val (v_in, v_out) = makeStateVar(ctx, relation.name, sort)
    val v_in_versioned = ctx.mkConst(getVersionedVariableName(relation, version), sort)
    val v_out_versioned = ctx.mkConst(getVersionedVariableName(relation, version+1), sort)
    val from: Array[Expr[_]] = Array(v_in, v_out)
    val to: Array[Expr[_]] = Array(v_in_versioned, v_out_versioned)
    expr.substitute(from, to)
  }
}
object RuleZ3Constraints {
  def apply(ctx:Context): RuleZ3Constraints = RuleZ3Constraints(ctx.mkTrue(), ctx.mkTrue(), Array(), Set())

  def getVersionedVariableName(relation: Relation, version: Int): String = {
    if (version > 0) s"${relation.name}_v${version}"
    else s"${relation.name}"
  }
}

class Verifier(program: Program, impAbsProgram: ImperativeAbstractProgram)
  extends AbstractImperativeTranslator(program, isInstrument = true) {

  private val ctx: Context = new Context()
  private val invariantGenerator: InvariantGenerator = InvariantGenerator(program.rules, impAbsProgram.indices)

  protected val relations: Set[Relation] = program.relations
  protected val indices: Map[SimpleRelation, List[Int]] = impAbsProgram.indices

  private val materializedRelations: Set[Relation] = getMaterializedRelations(impAbsProgram, program.interfaces)
       .filterNot(_.isInstanceOf[ReservedRelation])
  override val rulesToEvaluate: Set[Rule] = getRulesToEvaluate().filterNot(r => program.violations.contains(r.head.relation))

  val stateVars: Set[(Expr[_], Expr[_])] = materializedRelations.map(rel => {
    val sort = getSort(ctx, rel, getIndices(rel))
    makeStateVar(ctx, rel.name, sort)
  })

  private def getIndices(relation: Relation): List[Int] = relation match {
    case sr:SimpleRelation => indices.getOrElse(sr, List())
    case SingletonRelation(name, sig, memberNames) => List()
    case relation: ReservedRelation => List()
  }

  def check(): Unit = {
    val violationRules: Set[Rule] = program.rules.filter(r => program.violations.contains(r.head.relation))
    val tr = TransitionSystem(program.name, ctx)

    var initConditions: List[BoolExpr] = List()
    for (rel <- materializedRelations) {
      val sort = getSort(ctx, rel, getIndices(rel))
      val (v_in, _) = tr.newVar(rel.name, sort)
      val (_init, _,_) = getInitConstraints(rel, v_in)
      initConditions :+= _init
    }
    tr.setInit(ctx.mkAnd(initConditions.toArray:_*))

    val transitionConditions = getTransitionConstraints()
    tr.setTr(transitionConditions)

    for (vr <- violationRules) {
      val property = getProperty(ctx, vr)
      println(property)

      val (resInit, _resTr) = inductiveProve(ctx, tr, property)
      val resTr = _resTr match {
        case Status.UNSATISFIABLE => _resTr
        case Status.UNKNOWN | Status.SATISFIABLE => {
          findInvariant(tr, vr) match {
            case Some(inv) => {
              validateInvariant(inv, tr, property)
              println(s"invariant: ${inv}")
              Status.UNSATISFIABLE
            }
            case None => _resTr
          }
        }
      }
      println(s"Init: $resInit")
      println(s"Tr: $resTr")
    }
  }


  def inductiveProve(ctx: Context, ts: TransitionSystem, property: BoolExpr): (Status, Status) = {
    val resInit = prove(ctx, ctx.mkImplies(ts.getInit(), property))
    val f2 = ctx.mkImplies(ctx.mkAnd(property, ts.getTr()), ts.toPost(property))
    val resTr = prove(ctx, f2)
    (resInit, resTr)
  }


  def inductiveProve(ctx: Context, ts: TransitionSystem, property: BoolExpr, lemma: BoolExpr): (Status, Status) = {
    val resInit = prove(ctx, ctx.mkImplies(ts.getInit(), property))
    val f2 = ctx.mkImplies(ctx.mkAnd(property, ts.getTr(), lemma), ts.toPost(property))
    val resTr = prove(ctx, f2)
    (resInit, resTr)
  }


  private def _refuteInvariant(inv: BoolExpr, candidates: Set[BoolExpr], tr: TransitionSystem): Boolean = {
    val f = ctx.mkImplies(ctx.mkAnd((tr.getTr() +: candidates.toArray):_*), tr.toPost(inv))
    val res = prove(ctx, f)
    res != Status.UNSATISFIABLE
  }

  private def findInvariant(tr: TransitionSystem, propertyRule: Rule): Option[BoolExpr] = {
    val prefix = "i"
    val candidates = generateCandidateInvariants(ctx, propertyRule, prefix)
    println(s"${candidates.size} candidate invariants.")

    // debug
    // val lemma: Set[BoolExpr] = {
    //   val addrSort = ctx.mkBitVecSort(addressSize)
    //   val uintSort = ctx.mkBitVecSort(uintSize)
    //   val p = ctx.mkConst("p", addrSort)
    //   val n = ctx.mkConst("n", uintSort)
    //   val balance = ctx.mkConst("balance", ctx.mkArraySort(addrSort, uintSort))
    //   val highestBidTupleSort = ctx.mkTupleSort(ctx.mkSymbol("highestBidTuple"),
    //                           Array(ctx.mkSymbol("bidder"), ctx.mkSymbol("amount")), Array(addrSort, uintSort))
    //   val highestBid = ctx.mkConst("highestBid", highestBidTupleSort)
    //   val withdrawCount = ctx.mkConst("withdrawCount", ctx.mkArraySort(addrSort, uintSort))
    //   val premise = ctx.mkNot(ctx.mkEq(ctx.mkSelect(withdrawCount, p), ctx.mkBV(0,uintSize)))
    //   val _l1 = ctx.mkForall(Array(p), ctx.mkImplies(
    //     ctx.mkAnd(premise, ctx.mkEq(p, highestBidTupleSort.getFieldDecls.apply(0).apply(highestBid))),
    //     ctx.mkEq(ctx.mkSelect(balance, p), highestBidTupleSort.getFieldDecls.apply(1).apply(highestBid))
    //     ),
    //     1, null, null, ctx.mkSymbol("Q1"), ctx.mkSymbol("skid1"))

    //   val _l2 = ctx.mkForall(Array(p), ctx.mkImplies(
    //     ctx.mkAnd(premise, ctx.mkNot(ctx.mkEq(p, highestBidTupleSort.getFieldDecls.apply(0).apply(highestBid)))),
    //     ctx.mkEq(ctx.mkSelect(balance, p), ctx.mkBV(0,uintSize))
    //     ),
    //     1, null, null, ctx.mkSymbol("Q1"), ctx.mkSymbol("skid1"))

    //   val end = ctx.mkConst("end", ctx.mkBoolSort())
    //   val _l3 = ctx.mkForall(Array(p), ctx.mkImplies(
    //     ctx.mkNot(ctx.mkEq(ctx.mkSelect(withdrawCount, p), ctx.mkBV(0,uintSize))),
    //     end),
    //     1, null, null, ctx.mkSymbol("Q2"), ctx.mkSymbol("skid2"))
    //   Set(_l1,_l2, _l3)
    // }
    // val inv = findInvariant(tr, lemma)
    // val inv = findInvariant(tr, candidates ++ lemma)
    val inv = findInvariant(tr, candidates)
    inv
  }

  private def validateInvariant(inv: BoolExpr, tr: TransitionSystem, property: BoolExpr): Unit = {
    val (initRes, trRes) = inductiveProve(ctx, tr, inv)
    assert(initRes==Status.UNSATISFIABLE)
    assert(trRes==Status.UNSATISFIABLE)
    val (initRes2, trRes2) = inductiveProve(ctx, tr, property, inv)
    assert(initRes2 == Status.UNSATISFIABLE)
    assert(trRes2 == Status.UNSATISFIABLE)
  }

  private def findInvariant(tr: TransitionSystem, candidates: Set[BoolExpr]): Option[BoolExpr] = {

    println(s"${candidates.size} candidate invariants remain.")
    if (candidates.isEmpty) return None
    for (inv <- candidates) {
      if (_refuteInvariant(inv, candidates, tr)) {
        return findInvariant(tr, candidates - inv)
      }
    }
    Some(ctx.mkAnd(candidates.toArray:_*))
  }

  private def generateCandidateInvariants(ctx: Context, propertyRule: Rule, prefix: String): Set[BoolExpr] = {
    val transactionRules: Set[Rule] = program.rules.filter(r => r.body.exists(_.relation.name.startsWith(transactionRelationPrefix)))

    var candidates: Set[BoolExpr] = Set()

    for (rule <- transactionRules) {
      val _preds = invariantGenerator.extractPredicates(ctx,rule,prefix)
      val predicates: Set[BoolExpr] = _preds.map(
          p=>simplifyByRenamingConst(p,constOnly = false).simplify().asInstanceOf[BoolExpr])

      val (premise, keyConsts, keyTypes) = {
        var initConditions: Array[BoolExpr] = Array()
        var _keyConsts: Array[Expr[_]] = Array()
        var _keyTypes: Array[Type] = Array()
        for (rel <- materializedRelations.intersect(propertyRule.body.map(_.relation))) {
          val sort = getSort(ctx, rel, getIndices(rel))
          val (v_in, _) = makeStateVar(ctx, rel.name, sort)

          val (_init, _keys, _kts) = getInitConstraints(rel, v_in, isQuantified = false)
          initConditions :+= _init
          _keyConsts ++= _keys
          _keyTypes ++= _kts
        }
        (ctx.mkNot(ctx.mkAnd(initConditions:_*)), _keyConsts, _keyTypes)
      }

      /** Conjunct the premise with predicates form rules */
      val predicatesOnKeys: Set[BoolExpr] = {
        val _preds = keyTypes.flatMap(kt =>
          invariantGenerator.extractPredicates(ctx, rule, kt, prefix)).toSet
        _preds.map(p=>simplifyByRenamingConst(p,constOnly = false).simplify().asInstanceOf[BoolExpr])
      }

      val conditionalPremises: Set[BoolExpr] = predicatesOnKeys.map(p => ctx.mkAnd(premise, p))

      /** Bind the key variable to predicates */
      var from: Array[Expr[_]] = Array()
      var to: Array[Expr[_]] = Array()
      for ((k,t) <- keyConsts.zip(keyTypes)) {
        val params = rule.body.flatMap(_.fields).filter(_._type == t)
        for (p <- params) {
          val (_const, _) = paramToConst(ctx,p, prefix)
          from :+= _const
          to :+= k
        }
      }

      /** Generate invariants in the form of implications */
      for (eachPremise <- conditionalPremises+premise) {
        for (eachPred <- predicates) {
          val conclusion = ctx.mkNot(eachPred).simplify()
          val inv = if (keyConsts.nonEmpty) {
            val renamedPremise = eachPremise.substitute(from, to)
            val renamedConclusion = conclusion.substitute(from, to)
            ctx.mkForall(
              keyConsts,
              ctx.mkImplies(renamedPremise, renamedConclusion),
              1, null, null, ctx.mkSymbol(s"Qinv${candidates.size}"), ctx.mkSymbol(s"skidinv${candidates.size}")
            )
          }
          else {
            ctx.mkImplies(eachPremise, conclusion)
          }
          candidates += inv
        }
      }
    }
    candidates
  }

  private def getInitConstraints(relation: Relation, const: Expr[Sort], isQuantified:Boolean=true): (BoolExpr, Array[Expr[_]], Array[Type]) = relation match {
    case sr: SimpleRelation => {
      val (arraySort, keySorts, valueSort) = getArraySort(ctx, sr, indices(sr))
      val keyTypes: Array[Type] = indices(sr).map(i=>relation.sig(i)).toArray
      val valueIndices = relation.sig.indices.filterNot(i=>indices(sr).contains(i))
      val valueTypes: Array[Type] = valueIndices.map(i=>sr.sig(i)).toArray

      val initValues = if (!valueSort.isInstanceOf[TupleSort]) {
        initValue(ctx,valueTypes.head)
      }
      else {
        val _initValues = valueTypes.map(t => initValue(ctx,t))
        valueSort.asInstanceOf[TupleSort].mkDecl().apply(_initValues:_*)
      }

      val keyConstArray: Array[Expr[_]] = keyTypes.zipWithIndex.map{
          case (t,i) => ctx.mkConst(s"${t.name.toLowerCase()}$i", typeToSort(ctx,t))
      }

      val initConstraints = if (isQuantified) {
        ctx.mkForall(keyConstArray, ctx.mkEq(
          ctx.mkSelect(const.asInstanceOf[ArrayExpr[Sort,Sort]], keyConstArray),
          initValues),
          1, null, null, ctx.mkSymbol(s"Q${sr.name}"), ctx.mkSymbol(s"skid${sr.name}"))
      }
      else {
        ctx.mkEq(ctx.mkSelect(const.asInstanceOf[ArrayExpr[Sort,Sort]], keyConstArray), initValues)
      }
      (initConstraints, keyConstArray, keyTypes)
    }
    case SingletonRelation(name, sig, memberNames) => {
      val initConstraints = if (sig.size==1) {
        ctx.mkEq(const, initValue(ctx, sig.head))
      }
      else {
        val tupleSort = makeTupleSort(ctx, relation, sig.toArray, memberNames.toArray)
        val tupleConst = ctx.mkConst(name, tupleSort)
        val eqs = sig.zip(tupleSort.getFieldDecls).map {
          case (t, decl) => ctx.mkEq(decl.apply(tupleConst), initValue(ctx,t))
        }.toArray
        ctx.mkAnd(eqs: _*)
      }
      (initConstraints, Array(), Array())
    }
    case rel: ReservedRelation => ???
  }

  private def getProperty(ctx: Context, rule: Rule): BoolExpr = {
    /** Each violation query rule is translated into a property as follows:
     *  ! \E (V), P1 /\ P2 /\ ...
     *  where V is the set of variable appears in the rule body,
     *  P1, P2, ... are predicates translated from each rule body literal.
     *  */
    val prefix = "i"
    val bodyConstraints = rule.body.map(lit => literalToConst(ctx, lit, getIndices(lit.relation), prefix)).toArray
    val functorConstraints = rule.functors.map(f => functorToZ3(ctx,f, prefix)).toArray

    val keyConsts: Array[Expr[_]] = {
      var keys: Set[Parameter] = Set()
      for (lit <- rule.body) {
        val _indicies = getIndices(lit.relation)
        keys ++= _indicies.map(i=>lit.fields(i)).toSet
      }
      keys.map(p => paramToConst(ctx,p,prefix)._1).toArray
    }
    val constraints = {
      val _c = ctx.mkAnd(bodyConstraints++functorConstraints:_*)
      val renamed = simplifyByRenamingConst(_c, constOnly = false).simplify()
      renamed
    }

    if (keyConsts.nonEmpty) {
      ctx.mkNot(ctx.mkExists(
        keyConsts,
        constraints,
        1, null, null, ctx.mkSymbol("Q"), ctx.mkSymbol("skid2")
        )
      )
    }
    else {
      ctx.mkNot(constraints)
    }
  }

  private def getTransitionConstraints(): BoolExpr = {

    val triggers: Set[Trigger] = {
      val relationsToTrigger = program.interfaces.map(_.relation).filter(r => r.name.startsWith(transactionRelationPrefix))
      val relationsInBodies = program.rules.flatMap(_.body).map(_.relation)
      val toTrigger = relationsInBodies.intersect(relationsToTrigger)
      toTrigger.map(rel => InsertTuple(rel,primaryKeyIndices(rel)))
    }

    var transactionConstraints: List[BoolExpr] = List()
    var transactionConst: List[Expr[IntSort]] = List()
    for (t <- triggers) {
      var i: Int = 0
      val triggeredRules: Set[Rule] = getTriggeredRules(t)
      for (rule <- triggeredRules) {
        val ruleConsrtaint: BoolExpr = ruleToExpr(rule, t)

        /** Add the "unchanged" constraints */
        val unchangedConstraints: List[BoolExpr] = getUnchangedConstraints(ruleConsrtaint)

        /** A boolean value indicating which transaction branch gets evaluate to true */
        val trConst = ctx.mkIntConst(s"${t.relation.name}$i")
        i += 1

        transactionConst +:= trConst
        transactionConstraints +:= ctx.mkAnd(
          (ctx.mkEq(trConst, ctx.mkInt(1)) :: ruleConsrtaint :: unchangedConstraints).toArray: _*)
      }
    }

    ctx.mkAnd(
      ctx.mkAnd(transactionConst.map(c => ctx.mkOr(ctx.mkEq(c,ctx.mkInt(0)), ctx.mkEq(c,ctx.mkInt(1)))).toArray:_*),
      ctx.mkEq(ctx.mkAdd(transactionConst.toArray:_*), ctx.mkInt(1)),
      ctx.mkOr(transactionConstraints.toArray:_*)
    )
  }

  private def getUnchangedConstraints(_expr: BoolExpr): List[BoolExpr] = {
    var unchangedConstraints: List[BoolExpr] = List()
    val allVars = Prove.get_vars(_expr)
    for (rel <- materializedRelations) {
      val sort = getSort(ctx, rel, getIndices(rel))
      val (v_in, v_out) = makeStateVar(ctx, rel.name, sort)
      if (!allVars.contains(v_out)) {
        unchangedConstraints :+= ctx.mkEq(v_out, v_in)
      }
    }
    unchangedConstraints
  }

  private def ruleToExpr(rule: Rule, trigger: Trigger): BoolExpr = {
    var id = 0
    var versions: Map[Relation, Int] = Map()

    def _ruleToExpr(rule: Rule, trigger: Trigger):
      (Int, BoolExpr) = {
      val thisId = id
      id += 1

      val view = views(rule)
      val thisRelation = rule.head.relation
      val isMaterialized = materializedRelations.contains(thisRelation)

      val thisVersion = versions.getOrElse(rule.head.relation, 0)
      if (isMaterialized) {
        versions = versions.updated(rule.head.relation, thisVersion+1)
      }
      /** Add naming constraints  */
      def _renameConstraints(trigger: Trigger, nextId: Int, dependentRule: Rule, _body: BoolExpr):
      BoolExpr = {
        val (_, from, to) = getNamingConstraints(rule, dependentRule, trigger, thisId, nextId)
        val _renamed: BoolExpr = _body.substitute(from, to).asInstanceOf[BoolExpr]
        _renamed
      }


      val (trueBranch, falseBranch) = view.getZ3Constraint(ctx, trigger, isMaterialized, getPrefix(thisId))

      val trueBranchWithDependentConstraints = {

        if (trueBranch.nextTriggers.nonEmpty) {

          val dependentRulesAndTriggers: List[(Trigger,Rule)] = {
            var ret: List[(Trigger,Rule)] = List()
            for (t <- trueBranch.nextTriggers) {
              for (tr <- getTriggeredRules(t)) {
                for (nt <- views(tr).getTriggersForView(t)) {
                  ret :+= (nt, tr)
                }
              }
            }
            ret
          }

          var allDependentConstraints: List[BoolExpr] = List()
          for ((t, dr) <- dependentRulesAndTriggers) {
            val (nextId, dependentConstraint) = _ruleToExpr(dr, t)
            val renamedConstraint = _renameConstraints(t, nextId, dr, dependentConstraint)
            allDependentConstraints :+= renamedConstraint
          }

          val _dependentConstraints = ctx.mkAnd(allDependentConstraints :_*)

          val updateAndDependentConstraints = ctx.mkAnd(trueBranch.getVersionedUpdateConstraint(ctx, thisRelation, getIndices(thisRelation), thisVersion),
            _dependentConstraints)

          if (thisId == 0) {
            ctx.mkAnd(trueBranch.ruleConstraints, updateAndDependentConstraints)
          }
          else {
            ctx.mkImplies(trueBranch.ruleConstraints, updateAndDependentConstraints)
          }
        }
        else {
          trueBranch.ruleConstraints
        }
      }



      val allConstraints = if (!falseBranch.ruleConstraints.simplify().isFalse && thisId > 0) {
        ctx.mkXor(trueBranchWithDependentConstraints, falseBranch.ruleConstraints)
      }
      else {
        trueBranchWithDependentConstraints
      }

      (thisId, allConstraints)
    }

    val (_, expr) = _ruleToExpr(rule,trigger)
    val renamed = {
      /** Rename the latest version of state variables into [v_out] */
      var _from: Array[Expr[_]] = Array()
      var _to: Array[Expr[_]] = Array()
      for ((rel, latestVersion) <- versions) {
        val sort = getSort(ctx, rel, getIndices(rel))
        val (_, v_out) = makeStateVar(ctx, rel.name, sort)
        val v_id = ctx.mkConst(getVersionedVariableName(rel, latestVersion), sort)
        _from :+= v_id
        _to :+= v_out
      }
      expr.substitute(_from, _to).asInstanceOf[BoolExpr]
    }

    val simplified = simplifyByRenamingConst(renamed)
    simplified.asInstanceOf[BoolExpr]
  }

  private def getNamingConstraints(rule: Rule, dependentRule: Rule, trigger: Trigger, id1: Int, id2: Int): (BoolExpr, Array[Expr[_]], Array[Expr[_]]) = {
    val headLiteral = rule.head
    val bodyLiteral = views(dependentRule) match {
      case _: JoinView => {
        val _s = dependentRule.body.filter(_.relation == rule.head.relation)
        assert(_s.size==1)
        _s.head
      }
      case cv: CountView =>  cv.count.literal
      case mv: MaxView => mv.max.literal
      case sv: SumView => sv.sum.literal
      case _ => ???
    }

    /** If the trigger is delete tuple, rename the index variables only. */
    val indexOnly = trigger.isInstanceOf[DeleteTuple]
    val _indices = getIndices(headLiteral.relation)

    var expr: List[BoolExpr] = List()
    var from: List[Expr[_]] = List()
    var to: List[Expr[_]] = List()
    for ((v,i) <- headLiteral.fields.zip(bodyLiteral.fields).zipWithIndex) {
      if (v._1.name != "_" && v._2.name != "_" && (_indices.contains(i) || !indexOnly)) {
        val (x1,_) = paramToConst(ctx, v._1, getPrefix(id1))
        val (x2,_) = paramToConst(ctx, v._2, getPrefix(id2))
        expr +:= ctx.mkEq(x1,x2)
        to +:= x1
        from +:= x2
      }
    }
    (ctx.mkAnd(expr.toArray:_*), from.toArray, to.toArray)
  }

  private def simplifyByRenamingConst[T<:Sort](expr: Expr[T], constOnly:Boolean=true, exceptions: Set[Expr[_]]= Set()): Expr[T] = {
    def _isTempVar(e: Expr[_]): Boolean = {
      if (e.isApp) {
        if (e.getArgs.length == 0) {
          e.getSExpr.startsWith("i")
        }
        else false
      }
      else false
    }
    def _filterEquation(pair: (Expr[_], Expr[_])): Option[(Expr[_], Expr[_])] = {
      val (e1,e2) = pair
      if (_isTempVar(e1) && !exceptions.contains(e1)) {
        Some(pair)
      }
      else if (_isTempVar(e2) && !exceptions.contains(e2)) {
        Some(Tuple2(e2,e1))
      }
      else None
    }
    // val exceptions = stateVars.flatMap(t=>Set(t._1,t._2))
    // var pairs = extractEq(expr, exceptions).filter(_._1.getSExpr.startsWith("i"))
    var pairs = {
      val _ps = extractEq(expr,constOnly)
      val _filtered = _ps.flatMap(_filterEquation)
      _filtered
    }
    var newExpr = expr
    while (pairs.nonEmpty) {
      val renamed = newExpr.substitute(pairs.map(_._1), pairs.map(_._2))
      newExpr = renamed.simplify()
      // pairs = extractEq(newExpr, exceptions).filter(_._1.getSExpr.startsWith("i"))
      pairs = extractEq(newExpr,constOnly).flatMap(_filterEquation)
    }
    newExpr
  }


  private def getPrefix(id: Int): String = s"i$id"

}
