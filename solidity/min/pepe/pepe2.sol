contract Pepe {
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct TotalInTransferFromTuple {
    uint n;
    bool _valid;
  }
  struct TotalInTransferTuple {
    uint n;
    bool _valid;
  }
  struct TotalInitialTuple {
    uint n;
    bool _valid;
  }
  struct TotalOutTransferTuple {
    uint n;
    bool _valid;
  }
  struct IncreaseAllowanceTotalTuple {
    uint n;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct SpentTotalTuple {
    uint n;
    bool _valid;
  }
  struct DecreaseAllowanceTotalTuple {
    uint n;
    bool _valid;
  }
  struct TotalOutTransferFromTuple {
    uint n;
    bool _valid;
  }
  mapping(address=>TotalBurnTuple) totalBurn;
  OwnerTuple owner;
  mapping(address=>TotalInTransferFromTuple) totalInTransferFrom;
  mapping(address=>TotalInTransferTuple) totalInTransfer;
  mapping(address=>TotalInitialTuple) totalInitial;
  mapping(address=>TotalOutTransferTuple) totalOutTransfer;
  mapping(address=>TotalOutTransferFromTuple) totalOutTransferFrom;
  mapping(address=>mapping(address=>IncreaseAllowanceTotalTuple)) increaseAllowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>DecreaseAllowanceTotalTuple)) decreaseAllowanceTotal;
  event TransferFrom(address from,address to,address spender,uint amount);
  event Burn(address p,uint amount);
  event DecreaseAllowance(address p,address s,uint n);
  event SetRuleAction(bool b,address pair,uint max,uint min);
  event Transfer(address from,address to,uint amount);
  event IncreaseAllowance(address p,address s,uint n);
  event BlacklistAction(address p,bool b);
  constructor(uint totalSupply) public {
    updateTotalSupplyOnInsertConstructor_r16(totalSupply);
    updateOwnerOnInsertConstructor_r19();
    updateInitialMintOnInsertConstructor_r30(totalSupply);
    updateMinHoldingAmountOnInsertConstructor_r24();
    updateMaxHoldingAmountOnInsertConstructor_r18();
    updateUniswapV2PairOnInsertConstructor_r10();
    updateLimitedOnInsertConstructor_r31();
  }
  function approve(address s,uint n) public    {
      bool r29 = updateIncreaseAllowanceOnInsertRecv_approve_r29(s,n);
      bool r0 = updateDecreaseAllowanceOnInsertRecv_approve_r0(s,n);
      if(r29==false && r0==false) {
        revert("Rule condition failed");
      }
  }
  function increaseAllowance(address s,uint n) public    {
      bool r34 = updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r34(s,n);
      if(r34==false) {
        revert("Rule condition failed");
      }
  }
  function decreaseAllowance(address s,uint n) public    {
      bool r4 = updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r4(s,n);
      if(r4==false) {
        revert("Rule condition failed");
      }
  }
  function blacklist(address p,bool b) public    {
      bool r1 = updateBlacklistActionOnInsertRecv_blacklist_r1(p,b);
      if(r1==false) {
        revert("Rule condition failed");
      }
  }
  function burn(uint amount) public    {
      bool r25 = updateBurnOnInsertRecv_burn_r25(amount);
      if(r25==false) {
        revert("Rule condition failed");
      }
  }
  function setRule(bool b,address pair,uint max,uint min) public    {
      bool r26 = updateSetRuleActionOnInsertRecv_setRule_r26(b,pair,max,min);
      if(r26==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r33 = updateTransferOnInsertRecv_transfer_r33(to,amount);
      if(r33==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r13 = updateTransferFromOnInsertRecv_transferFrom_r13(from,to,amount);
      if(r13==false) {
        revert("Rule condition failed");
      }
  }
  function updateUniswapV2PairOnInsertConstructor_r10() private    {
      // Empty()
  }
  function updateBalanceOfOnIncrementTotalInitial_r22(address p,int i) private    {
      // Empty()
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r34(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      if(o!=address(0) && s!=address(0)) {
        updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r15(o,s,n);
        emit IncreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalBurn_r22(address p,int b) private    {
      // Empty()
  }
  function updateTotalInTransferFromOnInsertTransferFrom_r35(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInTransferFrom_r22(p,delta0);
      totalInTransferFrom[p].n += n;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBalanceOfOnIncrementTotalInTransfer_r22(address p,int t1) private    {
      // Empty()
  }
  function updateTotalInTransferOnInsertTransfer_r3(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInTransfer_r22(p,delta0);
      totalInTransfer[p].n += n;
  }
  function updateInitialMintOnInsertTransferFrom_r20(address p) private    {
      updateTotalInitialOnInsertInitialMint_r2(p,uint(0));
  }
  function updateInitialMintOnInsertTransfer_r6(address p) private    {
      updateTotalInitialOnInsertInitialMint_r2(p,uint(0));
  }
  function updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r9(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementDecreaseAllowanceTotal_r32(o,s,delta0);
      decreaseAllowanceTotal[o][s].n += n;
  }
  function updateInitialMintOnInsertConstructor_r30(uint n) private    {
      address p = msg.sender;
      updateTotalInitialOnInsertInitialMint_r2(p,n);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r13(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint k = allowance(o,s);
      uint m = balanceOf(o);
      if(n<=m && n<=k && o!=address(0) && r!=address(0)) {
        updateSpentTotalOnInsertTransferFrom_r12(o,s,n);
        updateInitialMintOnInsertTransferFrom_r20(o);
        updateInitialMintOnInsertTransferFrom_r5(r);
        updateTotalOutTransferFromOnInsertTransferFrom_r17(o,n);
        updateTotalInTransferFromOnInsertTransferFrom_r35(r,n);
        emit TransferFrom(o,r,s,n);
        return true;
      }
      return false;
  }
  function updateTotalSupplyOnInsertConstructor_r16(uint n) private    {
      // Empty()
  }
  function updateAllowanceOnIncrementSpentTotal_r32(address o,address s,int x) private    {
      // Empty()
  }
  function balanceOf(address p) private view  returns (uint) {
      uint t1 = totalInTransfer[p].n;
      uint b = totalBurn[p].n;
      uint o2 = totalOutTransferFrom[p].n;
      uint o1 = totalOutTransfer[p].n;
      uint i = totalInitial[p].n;
      uint t2 = totalInTransferFrom[p].n;
      uint s = ((((i+t1)+t2)-o1)-o2)-b;
      return s;
  }
  function updateTotalInitialOnInsertInitialMint_r2(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInitial_r22(p,delta0);
      totalInitial[p].n += n;
  }
  function updateBurnOnInsertRecv_burn_r25(uint n) private   returns (bool) {
      address p = msg.sender;
      uint m = balanceOf(p);
      if(p!=address(0) && n<=m) {
        updateTotalBurnOnInsertBurn_r28(p,n);
        updateInitialMintOnInsertBurn_r27(p);
        emit Burn(p,n);
        return true;
      }
      return false;
  }
  function updateTotalOutTransferOnInsertTransfer_r7(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOutTransfer_r22(p,delta0);
      totalOutTransfer[p].n += n;
  }
  function updateOwnerOnInsertConstructor_r19() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function allowance(address o,address s) private view  returns (uint) {
      uint x = spentTotal[o][s].n;
      uint d = decreaseAllowanceTotal[o][s].n;
      uint i = increaseAllowanceTotal[o][s].n;
      uint n = (i-d)-x;
      return n;
  }
  function updateDecreaseAllowanceOnInsertRecv_approve_r0(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance(o,s);
      if(n<m) {
        uint d = m-n;
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r9(o,s,d);
        emit DecreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertRecv_transfer_r33(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf(s);
      if(n<=m && s!=address(0) && r!=address(0)) {
        updateTotalInTransferOnInsertTransfer_r3(r,n);
        updateTotalOutTransferOnInsertTransfer_r7(s,n);
        updateInitialMintOnInsertTransfer_r6(r);
        updateInitialMintOnInsertTransfer_r11(s);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalOutTransferFrom_r22(address p,int o2) private    {
      // Empty()
  }
  function updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r15(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementIncreaseAllowanceTotal_r32(o,s,delta0);
      increaseAllowanceTotal[o][s].n += n;
  }
  function updateAllowanceOnIncrementIncreaseAllowanceTotal_r32(address o,address s,int i) private    {
      // Empty()
  }
  function updateBlacklistActionOnInsertRecv_blacklist_r1(address p,bool b) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        emit BlacklistAction(p,b);
        return true;
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r29(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance(o,s);
      if(n>=m) {
        uint d = n-m;
        updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r15(o,s,d);
        emit IncreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateInitialMintOnInsertTransferFrom_r5(address p) private    {
      updateTotalInitialOnInsertInitialMint_r2(p,uint(0));
  }
  function updateBalanceOfOnIncrementTotalOutTransfer_r22(address p,int o1) private    {
      // Empty()
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r4(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance(o,s);
      if(o!=address(0) && s!=address(0) && m>=n) {
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r9(o,s,n);
        emit DecreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
  function updateTotalOutTransferFromOnInsertTransferFrom_r17(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOutTransferFrom_r22(p,delta0);
      totalOutTransferFrom[p].n += n;
  }
  function updateSetRuleActionOnInsertRecv_setRule_r26(bool b,address p,uint mx,uint mn) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        emit SetRuleAction(b,p,mx,mn);
        return true;
      }
      return false;
  }
  function updateTotalBurnOnInsertBurn_r28(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r22(p,delta0);
      totalBurn[p].n += n;
  }
  function updateSpentTotalOnInsertTransferFrom_r12(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r32(o,s,delta0);
      spentTotal[o][s].n += n;
  }
  function updateAllowanceOnIncrementDecreaseAllowanceTotal_r32(address o,address s,int d) private    {
      // Empty()
  }
  function updateMaxHoldingAmountOnInsertConstructor_r18() private    {
      // Empty()
  }
  function updateMinHoldingAmountOnInsertConstructor_r24() private    {
      // Empty()
  }
  function updateInitialMintOnInsertTransfer_r11(address p) private    {
      updateTotalInitialOnInsertInitialMint_r2(p,uint(0));
  }
  function updateInitialMintOnInsertBurn_r27(address p) private    {
      updateTotalInitialOnInsertInitialMint_r2(p,uint(0));
  }
  function updateLimitedOnInsertConstructor_r31() private    {
      // Empty()
  }
  function updateBalanceOfOnIncrementTotalInTransferFrom_r22(address p,int t2) private    {
      // Empty()
  }
}