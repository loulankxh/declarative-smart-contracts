contract Controllable {
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct AllMintTuple {
    uint n;
    bool _valid;
  }
  struct SymbolTuple {
    uint n;
    bool _valid;
  }
  struct SpentTotalTuple {
    uint m;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct ControllerTuple {
    address p;
    bool _valid;
  }
  struct DecreaseAllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  struct TotalMintTuple {
    uint n;
    bool _valid;
  }
  struct NameTuple {
    uint n;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct DecimalsTuple {
    uint n;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct AllBurnTuple {
    uint n;
    bool _valid;
  }
  struct IncreaseAllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  mapping(address=>TotalInTuple) totalIn;
  mapping(address=>TotalOutTuple) totalOut;
  mapping(address=>TotalBurnTuple) totalBurn;
  mapping(address=>TotalMintTuple) totalMint;
  AllMintTuple allMint;
  SymbolTuple symbol;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  ControllerTuple controller;
  mapping(address=>mapping(address=>DecreaseAllowanceTotalTuple)) decreaseAllowanceTotal;
  NameTuple name;
  TotalSupplyTuple totalSupply;
  DecimalsTuple decimals;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  mapping(address=>mapping(address=>IncreaseAllowanceTotalTuple)) increaseAllowanceTotal;
  event Burn(address p,uint amount);
  event IncreaseAllowance(address owner,address spender,uint n);
  event Mint(address p,uint amount);
  event DecreaseAllowance(address owner,address spender,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(address p) public {
    updateNameOnInsertConstructor_r10();
    updateOwnerOnInsertConstructor_r30();
    updateTotalBalancesOnInsertConstructor_r7();
    updateSymbolOnInsertConstructor_r31();
    updateTotalSupplyOnInsertConstructor_r13();
    updateControllerOnInsertConstructor_r3(p);
    updateDecimalsOnInsertConstructor_r9();
  }
  function getSymbol() public view  returns (uint) {
      uint n = symbol.n;
      return n;
  }
  function controllerRedeem(address p,uint amount) public    {
      bool r6 = updateControllerRedeemOnInsertRecv_controllerRedeem_r6(p,amount);
      if(r6==false) {
        revert("Rule condition failed");
      }
  }
  function getDecimals() public view  returns (uint) {
      uint n = decimals.n;
      return n;
  }
  function controllerTransfer(address from,address to,uint amount) public    {
      bool r15 = updateControllerTransferOnInsertRecv_controllerTransfer_r15(from,to,amount);
      if(r15==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      AllowanceTuple memory allowanceTuple = allowance[p][s];
      uint n = allowanceTuple.n;
      return n;
  }
  function mint(address p,uint amount) public    {
      bool r16 = updateMintOnInsertRecv_mint_r16(p,amount);
      if(r16==false) {
        revert("Rule condition failed");
      }
  }
  function increaseAllowance(address spender,uint n) public    {
      bool r22 = updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r22(spender,n);
      if(r22==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r2 = updateDecreaseAllowanceOnInsertRecv_approve_r2(s,n);
      bool r20 = updateIncreaseAllowanceOnInsertRecv_approve_r20(s,n);
      if(r2==false && r20==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint n = balanceOfTuple.n;
      return n;
  }
  function burn(address p,uint amount) public    {
      bool r29 = updateBurnOnInsertRecv_burn_r29(p,amount);
      if(r29==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r24 = updateTransferOnInsertRecv_transfer_r24(to,amount);
      if(r24==false) {
        revert("Rule condition failed");
      }
  }
  function getName() public view  returns (uint) {
      uint n = name.n;
      return n;
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function decreaseAllowance(address spender,uint n) public    {
      bool r17 = updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r17(spender,n);
      if(r17==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r32 = updateTransferFromOnInsertRecv_transferFrom_r32(from,to,amount);
      if(r32==false) {
        revert("Rule condition failed");
      }
  }
  function updateBalanceOfOnInsertTotalOut_r28(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r28(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnInsertTotalIn_r28(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r28(p,toDelete.n);
      }
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r20(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint m = allowanceTuple.n;
      if(n>=m) {
        uint d = n-m;
        updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r5(o,s,d);
        emit IncreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r23(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r23(newValue);
  }
  function updateTotalInOnInsertTransfer_r11(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalIn_r28(p,delta2);
      totalIn[p].n += n;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalSupplyOnInsertConstructor_r13() private    {
      totalSupply = TotalSupplyTuple(0,true);
  }
  function updateTotalSupplyOnIncrementAllMint_r23(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r23(newValue);
  }
  function updateAllowanceOnInsertDecreaseAllowanceTotal_r12(address o,address s,uint d) private    {
      DecreaseAllowanceTotalTuple memory toDelete = decreaseAllowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteDecreaseAllowanceTotal_r12(o,s,toDelete.m);
      }
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      IncreaseAllowanceTotalTuple memory increaseAllowanceTotalTuple = increaseAllowanceTotal[s][o];
      uint m = increaseAllowanceTotalTuple.m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateAllBurnOnInsertBurn_r33(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r23(delta1);
      allBurn.n += n;
  }
  function updateAllowanceOnDeleteSpentTotal_r12(address o,address s,uint l) private    {
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      IncreaseAllowanceTotalTuple memory increaseAllowanceTotalTuple = increaseAllowanceTotal[s][o];
      uint m = increaseAllowanceTotalTuple.m;
      uint n = (m-l)-d;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateTotalSupplyOnInsertAllBurn_r23(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateBalanceOfOnDeleteTotalBurn_r28(address p,uint m) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r1(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementDecreaseAllowanceTotal_r12(o,s,delta0);
      decreaseAllowanceTotal[o][s].m += n;
  }
  function updateAllowanceOnIncrementIncreaseAllowanceTotal_r12(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(increaseAllowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertIncreaseAllowanceTotal_r12(o,s,newValue);
  }
  function updateBalanceOfOnInsertTotalBurn_r28(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r28(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateDecimalsOnInsertConstructor_r9() private    {
      decimals = DecimalsTuple(18,true);
  }
  function updateTotalBurnOnInsertBurn_r19(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r28(p,delta1);
      totalBurn[p].n += n;
  }
  function updateBurnOnInsertControllerRedeem_r27(address p,uint n) private    {
      updateAllBurnOnInsertBurn_r33(n);
      updateTotalBurnOnInsertBurn_r19(p,n);
      emit Burn(p,n);
  }
  function updateControllerRedeemOnInsertRecv_controllerRedeem_r6(address p,uint n) private   returns (bool) {
      address c = controller.p;
      if(c==msg.sender) {
        BalanceOfTuple memory balanceOfTuple = balanceOf[p];
        uint m = balanceOfTuple.n;
        if(p!=address(0) && n<=m) {
          updateBurnOnInsertControllerRedeem_r27(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTransferOnInsertControllerTransfer_r18(address s,address r,uint n) private    {
      updateTotalInOnInsertTransfer_r11(r,n);
      updateTotalOutOnInsertTransfer_r25(s,n);
      emit Transfer(s,r,n);
  }
  function updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r5(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementIncreaseAllowanceTotal_r12(o,s,delta0);
      increaseAllowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnIncrementTotalOut_r28(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r28(p,newValue);
  }
  function updateSymbolOnInsertConstructor_r31() private    {
      symbol = SymbolTuple(0,true);
  }
  function updateBalanceOfOnInsertTotalMint_r28(address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r28(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalSupplyOnInsertAllMint_r23(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r32(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint k = allowanceTuple.n;
      BalanceOfTuple memory balanceOfTuple = balanceOf[o];
      uint m = balanceOfTuple.n;
      if(m>=n && k>=n) {
        updateSpentTotalOnInsertTransferFrom_r8(o,s,n);
        updateTransferOnInsertTransferFrom_r0(o,r,n);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,uint n) private    {
      updateTotalInOnInsertTransfer_r11(r,n);
      updateTotalOutOnInsertTransfer_r25(o,n);
      emit Transfer(o,r,n);
  }
  function updateBalanceOfOnDeleteTotalIn_r28(address p,uint i) private    {
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateBalanceOfOnIncrementTotalMint_r28(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r28(p,newValue);
  }
  function updateBalanceOfOnIncrementTotalBurn_r28(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r28(p,newValue);
  }
  function updateTotalBalancesOnInsertConstructor_r7() private    {
      // Empty()
  }
  function updateAllowanceOnDeleteDecreaseAllowanceTotal_r12(address o,address s,uint d) private    {
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      IncreaseAllowanceTotalTuple memory increaseAllowanceTotalTuple = increaseAllowanceTotal[s][o];
      uint m = increaseAllowanceTotalTuple.m;
      uint n = (m-l)-d;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateAllowanceOnInsertSpentTotal_r12(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r12(o,s,toDelete.m);
      }
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      IncreaseAllowanceTotalTuple memory increaseAllowanceTotalTuple = increaseAllowanceTotal[s][o];
      uint m = increaseAllowanceTotalTuple.m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateTotalMintOnInsertMint_r21(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalMint_r28(p,delta2);
      totalMint[p].n += n;
  }
  function updateSpentTotalOnInsertTransferFrom_r8(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r12(o,s,delta0);
      spentTotal[o][s].m += n;
  }
  function updateNameOnInsertConstructor_r10() private    {
      name = NameTuple(0,true);
  }
  function updateAllowanceOnDeleteIncreaseAllowanceTotal_r12(address o,address s,uint m) private    {
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      uint n = (m-l)-d;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r22(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r5(o,s,n);
      emit IncreaseAllowance(o,s,n);
      return true;
      return false;
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r17(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r1(o,s,n);
      emit DecreaseAllowance(o,s,n);
      return true;
      return false;
  }
  function updateMintOnInsertRecv_mint_r16(address p,uint n) private   returns (bool) {
      address s = msg.sender;
      if(p!=address(0)) {
        updateTotalMintOnInsertMint_r21(p,n);
        updateAllMintOnInsertMint_r14(n);
        emit Mint(p,n);
        return true;
      }
      return false;
  }
  function updateControllerOnInsertConstructor_r3(address p) private    {
      controller = ControllerTuple(p,true);
  }
  function updateAllMintOnInsertMint_r14(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r23(delta0);
      allMint.n += n;
  }
  function updateBalanceOfOnDeleteTotalOut_r28(address p,uint o) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateAllowanceOnIncrementSpentTotal_r12(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r12(o,s,newValue);
  }
  function updateAllowanceOnIncrementDecreaseAllowanceTotal_r12(address o,address s,int d) private    {
      int _delta = int(d);
      uint newValue = updateuintByint(decreaseAllowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertDecreaseAllowanceTotal_r12(o,s,newValue);
  }
  function updateAllowanceOnInsertIncreaseAllowanceTotal_r12(address o,address s,uint m) private    {
      IncreaseAllowanceTotalTuple memory toDelete = increaseAllowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteIncreaseAllowanceTotal_r12(o,s,toDelete.m);
      }
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateBalanceOfOnDeleteTotalMint_r28(address p,uint n) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateControllerTransferOnInsertRecv_controllerTransfer_r15(address s,address r,uint n) private   returns (bool) {
      address c = controller.p;
      if(c==msg.sender) {
        BalanceOfTuple memory balanceOfTuple = balanceOf[s];
        uint m = balanceOfTuple.n;
        if(n<=m) {
          updateTransferOnInsertControllerTransfer_r18(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalOutOnInsertTransfer_r25(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalOut_r28(p,delta1);
      totalOut[p].n += n;
  }
  function updateDecreaseAllowanceOnInsertRecv_approve_r2(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint m = allowanceTuple.n;
      if(n<m) {
        uint d = m-n;
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r1(o,s,d);
        emit DecreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalIn_r28(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r28(p,newValue);
  }
  function updateBurnOnInsertRecv_burn_r29(address p,uint n) private   returns (bool) {
      address s = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint m = balanceOfTuple.n;
      if(p!=address(0) && n<=m) {
        updateAllBurnOnInsertBurn_r33(n);
        updateTotalBurnOnInsertBurn_r19(p,n);
        emit Burn(p,n);
        return true;
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r30() private    {
      address s = msg.sender;
      // Empty()
  }
  function updateTransferOnInsertRecv_transfer_r24(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[s];
      uint m = balanceOfTuple.n;
      if(n<=m) {
        updateTotalInOnInsertTransfer_r11(r,n);
        updateTotalOutOnInsertTransfer_r25(s,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
}