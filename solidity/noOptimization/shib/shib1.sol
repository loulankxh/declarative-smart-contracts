contract Shib {
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
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
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct AllMintTuple {
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
  OwnerTuple owner;
  mapping(address=>mapping(address=>DecreaseAllowanceTotalTuple)) decreaseAllowanceTotal;
  mapping(address=>TotalMintTuple) totalMint;
  TotalSupplyTuple totalSupply;
  AllMintTuple allMint;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  mapping(address=>mapping(address=>IncreaseAllowanceTotalTuple)) increaseAllowanceTotal;
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event DecreaseAllowance(address p,address s,uint n);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(uint name,uint symbol,uint decimals,uint totalSupply,address feeReceiver,address tokenOwnerAddress) public {
    updateBalanceOfOnInsertConstructor_r0(totalSupply,tokenOwnerAddress);
    updateSendOnInsertConstructor_r2(feeReceiver);
    updateTotalSupplyOnInsertConstructor_r4(totalSupply);
    updateOwnerOnInsertConstructor_r15();
    updateTotalBalancesOnInsertConstructor_r28(totalSupply);
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance[p][s].n;
      return n;
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function burn(uint amount) public    {
      bool r5 = updateBurnOnInsertRecv_burn_r5(amount);
      if(r5==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r18 = updateIncreaseAllowanceOnInsertRecv_approve_r18(s,n);
      bool r13 = updateDecreaseAllowanceOnInsertRecv_approve_r13(s,n);
      if(r18==false && r13==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r20 = updateTransferOnInsertRecv_transfer_r20(to,amount);
      if(r20==false) {
        revert("Rule condition failed");
      }
  }
  function decreaseAllowance(address s,uint n) public    {
      bool r24 = updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r24(s,n);
      if(r24==false) {
        revert("Rule condition failed");
      }
  }
  function increaseAllowance(address s,uint n) public    {
      bool r11 = updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r11(s,n);
      if(r11==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r26 = updateTransferFromOnInsertRecv_transferFrom_r26(from,to,amount);
      if(r26==false) {
        revert("Rule condition failed");
      }
  }
  function updateSendOnInsertConstructor_r2(address p) private    {
      uint n = msg.value;
      payable(p).send(n);
  }
  function updateBalanceOfOnDeleteTotalIn_r7(address p,uint i) private    {
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateBalanceOfOnInsertTotalIn_r7(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r7(p,toDelete.n);
      }
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalSupplyOnInsertAllBurn_r17(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateSpentTotalOnInsertTransferFrom_r9(address o,address s,uint n) private    {
      int delta2 = int(n);
      updateAllowanceOnIncrementSpentTotal_r1(o,s,delta2);
      spentTotal[o][s].m += n;
  }
  function updateAllowanceOnInsertSpentTotal_r1(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r1(o,s,toDelete.m);
      }
      uint d = decreaseAllowanceTotal[o][s].m;
      uint m = increaseAllowanceTotal[o][s].m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateTotalSupplyOnInsertConstructor_r4(uint n) private    {
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateBalanceOfOnDeleteTotalOut_r7(address p,uint o) private    {
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateAllowanceOnDeleteIncreaseAllowanceTotal_r1(address o,address s,uint m) private    {
      uint l = spentTotal[o][s].m;
      uint d = decreaseAllowanceTotal[o][s].m;
      uint n = (m-l)-d;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateAllowanceOnIncrementIncreaseAllowanceTotal_r1(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(increaseAllowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertIncreaseAllowanceTotal_r1(o,s,newValue);
  }
  function updateTransferOnInsertRecv_transfer_r20(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[s].n;
      if(n<=m) {
        updateTotalInOnInsertTransfer_r30(r,n);
        updateTotalOutOnInsertTransfer_r22(s,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateTotalOutOnInsertTransfer_r22(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalOut_r7(p,delta2);
      totalOut[p].n += n;
  }
  function updateBalanceOfOnDeleteTotalBurn_r7(address p,uint m) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r24(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r8(o,s,n);
      emit DecreaseAllowance(o,s,n);
      return true;
      return false;
  }
  function updateAllowanceOnIncrementSpentTotal_r1(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r1(o,s,newValue);
  }
  function updateTransferOnInsertTransferFrom_r12(address o,address r,uint n) private    {
      updateTotalInOnInsertTransfer_r30(r,n);
      updateTotalOutOnInsertTransfer_r22(o,n);
      emit Transfer(o,r,n);
  }
  function updateBalanceOfOnIncrementTotalOut_r7(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r7(p,newValue);
  }
  function updateAllBurnOnInsertBurn_r27(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r17(delta1);
      allBurn.n += n;
  }
  function updateTotalSupplyOnIncrementAllBurn_r17(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r17(newValue);
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r18(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      if(n>=m) {
        uint d = n-m;
        updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r29(o,s,d);
        emit IncreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateBurnOnInsertRecv_burn_r5(uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[s].n;
      if(s!=address(0) && n<=m) {
        updateTotalBurnOnInsertBurn_r16(s,n);
        updateAllBurnOnInsertBurn_r27(n);
        emit Burn(s,n);
        return true;
      }
      return false;
  }
  function updateAllowanceOnInsertIncreaseAllowanceTotal_r1(address o,address s,uint m) private    {
      IncreaseAllowanceTotalTuple memory toDelete = increaseAllowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteIncreaseAllowanceTotal_r1(o,s,toDelete.m);
      }
      uint l = spentTotal[o][s].m;
      uint d = decreaseAllowanceTotal[o][s].m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateAllowanceOnDeleteSpentTotal_r1(address o,address s,uint l) private    {
      uint d = decreaseAllowanceTotal[o][s].m;
      uint m = increaseAllowanceTotal[o][s].m;
      uint n = (m-l)-d;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateTotalBurnOnInsertBurn_r16(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r7(p,delta1);
      totalBurn[p].n += n;
  }
  function updateAllowanceOnInsertDecreaseAllowanceTotal_r1(address o,address s,uint d) private    {
      DecreaseAllowanceTotalTuple memory toDelete = decreaseAllowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteDecreaseAllowanceTotal_r1(o,s,toDelete.m);
      }
      uint l = spentTotal[o][s].m;
      uint m = increaseAllowanceTotal[o][s].m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateBalanceOfOnInsertConstructor_r0(uint n,address p) private    {
      balanceOf[p] = BalanceOfTuple(n,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalInOnInsertTransfer_r30(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r7(p,delta0);
      totalIn[p].n += n;
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r11(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r29(o,s,n);
      emit IncreaseAllowance(o,s,n);
      return true;
      return false;
  }
  function updateOwnerOnInsertConstructor_r15() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateAllowanceOnIncrementDecreaseAllowanceTotal_r1(address o,address s,int d) private    {
      int _delta = int(d);
      uint newValue = updateuintByint(decreaseAllowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertDecreaseAllowanceTotal_r1(o,s,newValue);
  }
  function updateDecreaseAllowanceOnInsertRecv_approve_r13(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      if(n<m) {
        uint d = m-n;
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r8(o,s,d);
        emit DecreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r8(address o,address s,uint n) private    {
      int delta2 = int(n);
      updateAllowanceOnIncrementDecreaseAllowanceTotal_r1(o,s,delta2);
      decreaseAllowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnIncrementTotalIn_r7(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r7(p,newValue);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r26(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint k = allowance[o][s].n;
      uint m = balanceOf[o].n;
      if(m>=n && k>=n) {
        updateSpentTotalOnInsertTransferFrom_r9(o,s,n);
        updateTransferOnInsertTransferFrom_r12(o,r,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnInsertTotalBurn_r7(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r7(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalBalancesOnInsertConstructor_r28(uint n) private    {
      // Empty()
  }
  function updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r29(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementIncreaseAllowanceTotal_r1(o,s,delta1);
      increaseAllowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnIncrementTotalBurn_r7(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r7(p,newValue);
  }
  function updateAllowanceOnDeleteDecreaseAllowanceTotal_r1(address o,address s,uint d) private    {
      uint l = spentTotal[o][s].m;
      uint m = increaseAllowanceTotal[o][s].m;
      uint n = (m-l)-d;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateBalanceOfOnInsertTotalOut_r7(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r7(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
}