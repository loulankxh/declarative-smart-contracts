contract Stbt {
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct TotalMintTuple {
    uint n;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  struct PermissionTuple {
    bool sendAllowed;
    bool receiveAllowed;
    uint expiryTime;
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
  struct LastDistributeTimeTuple {
    uint time;
    bool _valid;
  }
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct MinIntervalTuple {
    uint time;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct AllMintTuple {
    uint n;
    bool _valid;
  }
  struct DistributeTotalTuple {
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
  mapping(address=>TotalInTuple) totalIn;
  OwnerTuple owner;
  mapping(address=>TotalMintTuple) totalMint;
  TotalSupplyTuple totalSupply;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>PermissionTuple) permission;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  LastDistributeTimeTuple lastDistributeTime;
  mapping(address=>TotalOutTuple) totalOut;
  MinIntervalTuple minInterval;
  mapping(address=>TotalBurnTuple) totalBurn;
  AllMintTuple allMint;
  DistributeTotalTuple distributeTotal;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  event DistributeInterests(uint n,uint time);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor() public {
    updateTotalBalancesOnInsertConstructor_r28();
    updateTotalSupplyOnInsertConstructor_r0();
    updateOwnerOnInsertConstructor_r7();
  }
  function approve(address s,uint n) public    {
      bool r26 = updateIncreaseAllowanceOnInsertRecv_approve_r26(s,n);
      if(r26==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address p,uint amount) public    {
      bool r24 = updateMintOnInsertRecv_mint_r24(p,amount);
      if(r24==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function transfer(address to,uint amount) public    {
      bool r3 = updateTransferOnInsertRecv_transfer_r3(to,amount);
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance[p][s].n;
      return n;
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r20 = updateTransferFromOnInsertRecv_transferFrom_r20(from,to,amount);
      if(r20==false) {
        revert("Rule condition failed");
      }
  }
  function distributeInterests(uint n) public    {
      bool r16 = updateDistributeInterestsOnInsertRecv_distributeInterests_r16(n);
      if(r16==false) {
        revert("Rule condition failed");
      }
  }
  function burn(address p,uint amount) public    {
      bool r15 = updateBurnOnInsertRecv_burn_r15(p,amount);
      if(r15==false) {
        revert("Rule condition failed");
      }
  }
  function updateLastDistributeTimeOnInsertDistributeInterests_r2(uint t) private    {
      uint _max = lastDistributeTime.time;
      if(t>_max) {
        lastDistributeTime = LastDistributeTimeTuple(m,true);
      }
  }
  function updateBalanceOfOnDeleteTotalIn_r5(address p,uint i) private    {
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateBalanceOfOnDeleteTotalMint_r5(address p,uint n) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalBurnOnInsertBurn_r12(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r5(p,delta1);
      totalBurn[p].n += n;
  }
  function updateTotalSupplyOnInsertAllBurn_r19(uint b) private    {
      uint d = distributeTotal.n;
      uint m = allMint.n;
      uint n = (m-b)-d;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateBalanceOfOnInsertTotalBurn_r5(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r5(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalMintOnInsertMint_r13(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMint_r5(p,delta0);
      totalMint[p].n += n;
  }
  function updateBalanceOfOnIncrementTotalMint_r5(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r5(p,newValue);
  }
  function updateTransferOnInsertRecv_transfer_r3(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[s].n;
      if(n<=m && canSend(s) && canRecv(r)) {
        updateTotalOutOnInsertTransfer_r17(s,n);
        updateTotalInOnInsertTransfer_r9(r,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateSpentTotalOnInsertTransferFrom_r6(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementSpentTotal_r23(o,s,delta1);
      spentTotal[o][s].m += n;
  }
  function updateBalanceOfOnInsertTotalMint_r5(address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r5(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTransferOnInsertTransferFrom_r11(address o,address r,address _spender2,uint n) private    {
      updateTotalOutOnInsertTransfer_r17(o,n);
      updateTotalInOnInsertTransfer_r9(r,n);
      emit Transfer(o,r,n);
  }
  function updateAllowanceOnIncrementAllowanceTotal_r23(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r23(o,s,newValue);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r27(address o,address s,uint n) private    {
      int delta2 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r23(o,s,delta2);
      allowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnIncrementTotalOut_r5(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r5(p,newValue);
  }
  function updateBalanceOfOnIncrementTotalIn_r5(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r5(p,newValue);
  }
  function updateBalanceOfOnInsertTotalOut_r5(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r5(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateAllowanceOnDeleteAllowanceTotal_r23(address o,address s,uint m) private    {
      uint l = spentTotal[o][s].m;
      uint n = m-l;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateBalanceOfOnIncrementTotalBurn_r5(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r5(p,newValue);
  }
  function updateTotalSupplyOnInsertDistributeTotal_r19(uint d) private    {
      uint b = allBurn.n;
      uint m = allMint.n;
      uint n = (m-b)-d;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateOwnerOnInsertConstructor_r7() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateBurnOnInsertRecv_burn_r15(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOf[p].n;
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r12(p,n);
          updateAllBurnOnInsertBurn_r25(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function canSend(address s) private view  returns (bool) {
      if(true==permission[s].sendAllowed && 0==permission[s].expiryTime) {
        return true;
      }
      uint t = block.timestamp;
      if(true==permission[s].sendAllowed) {
        uint expire = permission[s].expiryTime;
        if(t<expire) {
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnDeleteTotalBurn_r5(address p,uint m) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r26(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r27(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateBalanceOfOnInsertTotalIn_r5(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r5(p,toDelete.n);
      }
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateAllowanceOnInsertSpentTotal_r23(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r23(o,s,toDelete.m);
      }
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalSupplyOnInsertConstructor_r0() private    {
      totalSupply = TotalSupplyTuple(0,true);
  }
  function updateTotalSupplyOnIncrementDistributeTotal_r19(int d) private    {
      int _delta = int(d);
      uint newValue = updateuintByint(distributeTotal.n,_delta);
      updateTotalSupplyOnInsertDistributeTotal_r19(newValue);
  }
  function updateAllowanceOnDeleteSpentTotal_r23(address o,address s,uint l) private    {
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateAllowanceOnInsertAllowanceTotal_r23(address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r23(o,s,toDelete.m);
      }
      uint l = spentTotal[o][s].m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function canRecv(address s) private view  returns (bool) {
      if(true==permission[s].receiveAllowed && 0==permission[s].expiryTime) {
        return true;
      }
      uint t = block.timestamp;
      if(true==permission[s].receiveAllowed) {
        uint expire = permission[s].expiryTime;
        if(t<expire) {
          return true;
        }
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r19(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r19(newValue);
  }
  function updateTotalBalancesOnInsertConstructor_r28() private    {
      // Empty()
  }
  function updateTotalSupplyOnIncrementAllMint_r19(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r19(newValue);
  }
  function updateDistributeTotalOnInsertDistributeInterests_r8(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementDistributeTotal_r19(delta0);
      distributeTotal.n += n;
  }
  function updateTotalOutOnInsertTransfer_r17(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalOut_r5(p,delta2);
      totalOut[p].n += n;
  }
  function updateAllBurnOnInsertBurn_r25(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r19(delta0);
      allBurn.n += n;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r20(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[o].n;
      uint k = allowance[o][s].n;
      if(m>=n && k>=n && canSend(s) && canRecv(r)) {
        updateSpentTotalOnInsertTransferFrom_r6(o,s,n);
        updateTransferOnInsertTransferFrom_r11(o,r,s,n);
        return true;
      }
      return false;
  }
  function updateTotalInOnInsertTransfer_r9(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalIn_r5(p,delta2);
      totalIn[p].n += n;
  }
  function updateAllowanceOnIncrementSpentTotal_r23(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r23(o,s,newValue);
  }
  function updateTotalSupplyOnInsertAllMint_r19(uint m) private    {
      uint d = distributeTotal.n;
      uint b = allBurn.n;
      uint n = (m-b)-d;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateAllMintOnInsertMint_r1(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllMint_r19(delta1);
      allMint.n += n;
  }
  function updateMintOnInsertRecv_mint_r24(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateTotalMintOnInsertMint_r13(p,n);
          updateAllMintOnInsertMint_r1(n);
          emit Mint(p,n);
          return true;
        }
      }
      return false;
  }
  function updateDistributeInterestsOnInsertRecv_distributeInterests_r16(uint n) private   returns (bool) {
      uint t1 = lastDistributeTime.time;
      uint i = minInterval.time;
      uint t = block.timestamp;
      if(t1-t>i) {
        updateLastDistributeTimeOnInsertDistributeInterests_r2(t);
        updateDistributeTotalOnInsertDistributeInterests_r8(n);
        emit DistributeInterests(n,t);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnDeleteTotalOut_r5(address p,uint o) private    {
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
}