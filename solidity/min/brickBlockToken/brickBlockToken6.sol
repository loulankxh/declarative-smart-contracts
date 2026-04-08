contract BrickBlockToken {
  struct BrickblockTokenTuple {
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct DecreaseTotalTuple {
    uint m;
    bool _valid;
  }
  struct PausedTuple {
    bool p;
    bool _valid;
  }
  struct AllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  struct OnceUnpausedTuple {
    bool b;
    bool _valid;
  }
  struct SpentTotalTuple {
    uint m;
    bool _valid;
  }
  struct OnceUpgradeTuple {
    bool b;
    bool _valid;
  }
  struct BalancesTuple {
    uint a;
    bool _valid;
  }
  struct OnceEndSaleTuple {
    bool b;
    bool _valid;
  }
  struct SuccessorAddressTuple {
    address p;
    bool _valid;
  }
  struct BonusShareTuple {
    uint n;
    bool _valid;
  }
  struct TokenSaleActiveTuple {
    bool b;
    bool _valid;
  }
  struct DeadTuple {
    bool b;
    bool _valid;
  }
  BrickblockTokenTuple BrickblockToken;
  mapping(address=>mapping(address=>DecreaseTotalTuple)) decreaseTotal;
  mapping(address=>BalancesTuple) balances;
  PausedTuple paused;
  OnceEndSaleTuple onceEndSale;
  SuccessorAddressTuple successorAddress;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  BonusShareTuple bonusShare;
  TokenSaleActiveTuple tokenSaleActive;
  OnceUnpausedTuple onceUnpaused;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  DeadTuple dead;
  OnceUpgradeTuple onceUpgrade;
  OwnerTuple owner;
  event Approve(address owner,address operator,uint n);
  event Transfer(address from,address to,uint a);
  event IncreaseAllowance(address o,address s,uint d);
  event DecreaseAllowance(address o,address s,uint a);
  event TransferBeforeUnpause();
  event Pause();
  event TransferOwnership(address old,address _new);
  event TransferAfterEndSale();
  event Upgrade(address p);
  event EvacuateAfterUpgrade();
  event Unpause();
  constructor() public {
    updateOnceUnpausedOnInsertConstructor_r41();
    updateOnceUpgradeOnInsertConstructor_r18();
    updateOwnerOnInsertConstructor_r42();
    updatePausedOnInsertConstructor_r10();
    updateOnceEndSaleOnInsertConstructor_r4();
  }
  function transferFrom(address from,address to,uint a) public    {
      bool r24 = updateTransferFromOnInsertRecv_transferFrom_r24(from,to,a);
      if(r24==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r34 = updateApproveOnInsertRecv_approve_r34(s,n);
      bool r13 = updateDecreaseAllowanceOnInsertRecv_approve_r13(s,n);
      bool r47 = updateIncreaseAllowanceOnInsertRecv_approve_r47(s,n);
      if(r34==false && r13==false && r47==false) {
        revert("Rule condition failed");
      }
  }
  function finalizeTokenSale() public    {
      bool r30 = updateFinalizeTokenSaleOnInsertRecv_finalizeTokenSale_r30();
      if(r30==false) {
        revert("Rule condition failed");
      }
  }
  function increaseApproval(address s,uint a) public    {
      bool r35 = updateIncreaseAllowanceOnInsertRecv_increaseApproval_r35(s,a);
      if(r35==false) {
        revert("Rule condition failed");
      }
  }
  function decreaseApproval(address s,uint a) public    {
      bool r1 = updateDecreaseAllowanceOnInsertRecv_decreaseApproval_r1(s,a);
      if(r1==false) {
        revert("Rule condition failed");
      }
  }
  function distributeTokens(address p,uint v) public    {
      bool r27 = updateDistributeTokensOnInsertRecv_distributeTokens_r27(p,v);
      if(r27==false) {
        revert("Rule condition failed");
      }
  }
  function unpause() public    {
      bool r3 = updateUnpauseOnInsertRecv_unpause_r3();
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function upgrade(address p) public    {
      bool r38 = updateUpgradeOnInsertRecv_upgrade_r38(p);
      if(r38==false) {
        revert("Rule condition failed");
      }
  }
  function evacuate(address p) public    {
      bool r12 = updateBurnOnInsertRecv_evacuate_r12(p);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function changeFountainContractAddress(address p) public    {
      bool r19 = updateFountainContractAddressOnInsertRecv_changeFountainContractAddress_r19(p);
      if(r19==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint a) public    {
      bool r20 = updateTransferOnInsertRecv_transfer_r20(to,a);
      if(r20==false) {
        revert("Rule condition failed");
      }
  }
  function updateAllowedOnIncrementAllowanceTotal_r26(address f,address s,int n) private    {
      // Empty()
  }
  function updateDecreaseTotalOnInsertDecreaseAllowance_r29(address f,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowedOnIncrementDecreaseTotal_r26(f,s,delta0);
      decreaseTotal[f][s].m += n;
  }
  function updateTotalInOnInsertTransfer_r25(address p,uint n) private    {
      int delta0 = int(n);
      updateBalancesOnIncrementTotalIn_r21(p,delta0);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r15(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowedOnIncrementAllowanceTotal_r26(o,s,delta0);
      allowanceTotal[o][s].m += n;
  }
  function updateTransferOnInsertTransferFrom_r11(address _operator0,address s,address r,uint n) private    {
      updateTotalInOnInsertTransfer_r25(r,n);
      updateTotalOutOnInsertTransfer_r14(s,n);
      emit Transfer(s,r,n);
  }
  function updateDistributeTokensOnInsertRecv_distributeTokens_r27(address a,uint n) private   returns (bool) {
      bool b = tokenSaleActive.b;
      address s = owner.p;
      if(s==msg.sender) {
        if(b==true && a!=address(0) && a!=s) {
          updateTransferOnInsertDistributeTokens_r40(a,n);
          return true;
        }
      }
      return false;
  }
  function updateFinalizeTokenSaleOnInsertRecv_finalizeTokenSale_r30() private   returns (bool) {
      address fa = fountainContractAddress.p;
      address s = msg.sender;
      if(true==tokenSaleActive.b) {
        address a = bonusDistributionAddress.p;
        if(s==owner.p) {
          if(a!=address(0) && fa!=address(0)) {
            updateTokenSaleActiveOnInsertFinalizeTokenSale_r28();
            updateOnceEndSaleOnInsertFinalizeTokenSale_r46();
            updateTransferOnInsertFinalizeTokenSale_r0();
            return true;
          }
        }
      }
      return false;
  }
  function updatePausedOnInsertConstructor_r10() private    {
      paused = PausedTuple(true,true);
  }
  function updateDecreaseAllowanceOnInsertRecv_approve_r13(address o,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = allowed(o,s);
      if(n<m) {
        uint d = m-n;
        updateDecreaseTotalOnInsertDecreaseAllowance_r29(o,s,d);
        emit DecreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r42() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateOnceUnpausedOnInsertUnpause_r17() private    {
      onceUnpaused = OnceUnpausedTuple(true,true);
  }
  function updateTokenSaleActiveOnInsertFinalizeTokenSale_r28() private    {
      tokenSaleActive = TokenSaleActiveTuple(false,true);
  }
  function updatePausedOnInsertUnpause_r48() private    {
      paused = PausedTuple(false,true);
  }
  function updateBalancesOnIncrementTotalIn_r21(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(balances[p].a,_delta);
      balances[p].a = newValue;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r24(address f,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balances[f].a;
      uint a = allowed(f,s);
      if(r!=address(0) && n<=m && n<=a) {
        updateSpentTotalOnInsertTransferFrom_r5(s,f,n);
        updateTransferOnInsertTransferFrom_r11(s,f,r,n);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertFinalizeTokenSale_r0() private    {
      uint bs = bonusShare.n;
      address p = address(this);
      address bda = bonusDistributionAddress.p;
      if(initialSupply(s)) {
        uint n = (s*bs)/100;
        updateTotalInOnInsertTransfer_r25(bda,n);
        updateTotalOutOnInsertTransfer_r14(p,n);
        emit Transfer(p,bda,n);
      }
  }
  function updateOnceEndSaleOnInsertFinalizeTokenSale_r46() private    {
      onceEndSale = OnceEndSaleTuple(true,true);
  }
  function updateTotalOutOnInsertTransfer_r14(address p,uint n) private    {
      int delta0 = int(n);
      updateBalancesOnIncrementTotalOut_r21(p,delta0);
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r47(address o,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = allowed(o,s);
      if(n>m) {
        uint d = n-m;
        updateAllowanceTotalOnInsertIncreaseAllowance_r15(o,s,d);
        emit IncreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertDistributeTokens_r40(address p,uint n) private    {
      address s = address(this);
      updateTotalOutOnInsertTransfer_r14(s,n);
      updateTotalInOnInsertTransfer_r25(p,n);
      emit Transfer(s,p,n);
  }
  function updateTransferOnInsertBurn_r2(address s,uint n) private    {
      updateTotalOutOnInsertTransfer_r14(s,n);
      updateTotalInOnInsertTransfer_r25(address(0),n);
      emit Transfer(s,address(0),n);
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseApproval_r35(address s,uint m) private   returns (bool) {
      address o = msg.sender;
      updateAllowanceTotalOnInsertIncreaseAllowance_r15(o,s,m);
      emit IncreaseAllowance(o,s,m);
      return true;
      return false;
  }
  function updatePausedOnInsertUpgrade_r6(address _p0) private    {
      paused = PausedTuple(true,true);
  }
  function updateDeadOnInsertUpgrade_r43(address _p0) private    {
      dead = DeadTuple(true,true);
  }
  function allowed(address f,address s) private view  returns (uint) {
      uint d = decreaseTotal[f][s].m;
      uint l = spentTotal[f][s].m;
      uint n = allowanceTotal[f][s].m;
      uint m = (n-l)-d;
      return m;
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseApproval_r1(address s,uint m) private   returns (bool) {
      address o = msg.sender;
      uint n = allowed(o,s);
      if(n>=m) {
        uint d = n-m;
        updateDecreaseTotalOnInsertDecreaseAllowance_r29(o,s,d);
        emit DecreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateAllowedOnIncrementDecreaseTotal_r26(address f,address s,int d) private    {
      // Empty()
  }
  function updateOnceUnpausedOnInsertConstructor_r41() private    {
      onceUnpaused = OnceUnpausedTuple(false,true);
  }
  function updateSpentTotalOnInsertTransferFrom_r5(address f,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowedOnIncrementSpentTotal_r26(f,s,delta0);
      spentTotal[f][s].m += n;
  }
  function updateOnceUpgradeOnInsertConstructor_r18() private    {
      onceUpgrade = OnceUpgradeTuple(false,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateFountainContractAddressOnInsertRecv_changeFountainContractAddress_r19(address a) private   returns (bool) {
      address thisAddr = address(this);
      address s = owner.p;
      if(s==msg.sender) {
        if(a!=s && thisAddr!=a) {
          return true;
        }
      }
      return false;
  }
  function updateBurnOnInsertRecv_evacuate_r12(address p) private   returns (bool) {
      address s = msg.sender;
      if(true==dead.b) {
        if(s==successorAddress.p) {
          uint n = balances[p].a;
          updateTransferOnInsertBurn_r2(p,n);
          return true;
        }
      }
      return false;
  }
  function updateAllowedOnIncrementSpentTotal_r26(address f,address s,int l) private    {
      // Empty()
  }
  function updateOnceUpgradeOnInsertUpgrade_r36(address _p0) private    {
      onceUpgrade = OnceUpgradeTuple(true,true);
  }
  function updateOnceEndSaleOnInsertConstructor_r4() private    {
      onceEndSale = OnceEndSaleTuple(false,true);
  }
  function initialSupply(uint a) private view  returns (bool) {
      return true;
      return false;
  }
  function updateUnpauseOnInsertRecv_unpause_r3() private   returns (bool) {
      address s = msg.sender;
      bool b = paused.p;
      if(false==dead.b) {
        if(s==owner.p) {
          if(b==true) {
            updateOnceUnpausedOnInsertUnpause_r17();
            updatePausedOnInsertUnpause_r48();
            emit Unpause();
            return true;
          }
        }
      }
      return false;
  }
  function updateApproveOnInsertRecv_approve_r34(address o,uint n) private   returns (bool) {
      address s = msg.sender;
      emit Approve(s,o,n);
      return true;
      return false;
  }
  function updateUpgradeOnInsertRecv_upgrade_r38(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateOnceUpgradeOnInsertUpgrade_r36(p);
          updatePausedOnInsertUpgrade_r6(p);
          updateDeadOnInsertUpgrade_r43(p);
          emit Upgrade(p);
          return true;
        }
      }
      return false;
  }
  function updateBalancesOnIncrementTotalOut_r21(address p,int o) private    {
      int _delta = int(-o);
      uint newValue = updateuintByint(balances[p].a,_delta);
      balances[p].a = newValue;
  }
  function updateTransferOnInsertRecv_transfer_r20(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(false==paused.p) {
        uint m = balances[s].a;
        if(r!=address(0) && n<=m) {
          updateTotalInOnInsertTransfer_r25(r,n);
          updateTotalOutOnInsertTransfer_r14(s,n);
          emit Transfer(s,r,n);
          return true;
        }
      }
      return false;
  }
}