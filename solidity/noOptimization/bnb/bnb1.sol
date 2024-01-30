contract Bnb {
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct TotalFreezeTuple {
    uint n;
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
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct TotalUnfreezeTuple {
    uint n;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct FreezeOfTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTotalTuple {
    uint m;
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
  mapping(address=>TotalOutTuple) totalOut;
  mapping(address=>TotalFreezeTuple) totalFreeze;
  OwnerTuple owner;
  mapping(address=>FreezeOfTuple) freezeOf;
  mapping(address=>TotalMintTuple) totalMint;
  TotalSupplyTuple totalSupply;
  AllMintTuple allMint;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  mapping(address=>TotalUnfreezeTuple) totalUnfreeze;
  mapping(address=>TotalBurnTuple) totalBurn;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event WithdrawEther(address p,uint amount);
  event IncreaseAllowance(address p,address s,uint n);
  event Unfreeze(address p,uint n);
  event Freeze(address p,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(uint initialSupply) public {
    updateTotalBalancesOnInsertConstructor_r23(initialSupply);
    updateAllMintOnInsertConstructor_r8(initialSupply);
    updateTotalInOnInsertConstructor_r28(initialSupply);
    updateOwnerOnInsertConstructor_r33();
    updateTotalMintOnInsertConstructor_r30(initialSupply);
    updateTotalSupplyOnInsertConstructor_r5(initialSupply);
    updateBalanceOfOnInsertConstructor_r4(initialSupply);
  }
  function freeze(uint n) public    {
      bool r22 = updateFreezeOnInsertRecv_freeze_r22(n);
      if(r22==false) {
        revert("Rule condition failed");
      }
  }
  function withdrawEther(uint amount) public    {
      bool r21 = updateWithdrawEtherOnInsertRecv_withdrawEther_r21(amount);
      if(r21==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint n = balanceOfTuple.n;
      return n;
  }
  function transfer(address to,uint amount) public    {
      bool r7 = updateTransferOnInsertRecv_transfer_r7(to,amount);
      if(r7==false) {
        revert("Rule condition failed");
      }
  }
  function unfreeze(uint n) public    {
      bool r6 = updateUnfreezeOnInsertRecv_unfreeze_r6(n);
      if(r6==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      AllowanceTuple memory allowanceTuple = allowance[p][s];
      uint n = allowanceTuple.n;
      return n;
  }
  function approve(address s,uint n) public    {
      bool r27 = updateIncreaseAllowanceOnInsertRecv_approve_r27(s,n);
      if(r27==false) {
        revert("Rule condition failed");
      }
  }
  function burn(uint amount) public    {
      bool r14 = updateBurnOnInsertRecv_burn_r14(amount);
      if(r14==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r32 = updateTransferFromOnInsertRecv_transferFrom_r32(from,to,amount);
      if(r32==false) {
        revert("Rule condition failed");
      }
  }
  function updateFreezeOfOnIncrementTotalUnfreeze_r11(address p,int u) private    {
      int _delta = int(u);
      uint newValue = updateuintByint(totalUnfreeze[p].n,_delta);
      updateFreezeOfOnInsertTotalUnfreeze_r11(p,newValue);
  }
  function updateBalanceOfOnInsertTotalOut_r13(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r13(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      uint f = freezeOfTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateAllowanceOnDeleteSpentTotal_r24(address o,address s,uint l) private    {
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o];
      uint m = allowanceTotalTuple.m;
      uint n = m-l;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r27(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint m = allowanceTuple.n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r31(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateFreezeOfOnDeleteTotalUnfreeze_r11(address p,uint u) private    {
      TotalFreezeTuple memory totalFreezeTuple = totalFreeze[p];
      uint f = totalFreezeTuple.n;
      uint n = f-u;
      updateBalanceOfOnDeleteFreezeOf_r13(p,n);
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      if(n==freezeOfTuple.n) {
        freezeOf[p] = FreezeOfTuple(0,false);
      }
  }
  function updateAllowanceOnIncrementAllowanceTotal_r24(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r24(o,s,newValue);
  }
  function updateBalanceOfOnInsertConstructor_r4(uint n) private    {
      address s = msg.sender;
      balanceOf[s] = BalanceOfTuple(n,true);
  }
  function updateFreezeOnInsertRecv_freeze_r22(uint n) private   returns (bool) {
      address p = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint m = balanceOfTuple.n;
      if(n<=m && n>0) {
        updateTotalFreezeOnInsertFreeze_r0(p,n);
        emit Freeze(p,n);
        return true;
      }
      return false;
  }
  function updateSpentTotalOnInsertTransferFrom_r20(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r24(o,s,delta0);
      spentTotal[o][s].m += n;
  }
  function updateTotalOutOnInsertTransfer_r18(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalOut_r13(p,delta1);
      totalOut[p].n += n;
  }
  function updateTotalInOnInsertConstructor_r28(uint n) private    {
      address s = msg.sender;
      updateBalanceOfOnInsertTotalIn_r13(s,n);
      totalIn[s] = TotalInTuple(n,true);
  }
  function updateTotalUnfreezeOnInsertUnfreeze_r12(address p,uint n) private    {
      int delta2 = int(n);
      updateFreezeOfOnIncrementTotalUnfreeze_r11(p,delta2);
      totalUnfreeze[p].n += n;
  }
  function updateBalanceOfOnIncrementTotalBurn_r13(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r13(p,newValue);
  }
  function updateFreezeOfOnIncrementTotalFreeze_r11(address p,int f) private    {
      int _delta = int(f);
      uint newValue = updateuintByint(totalFreeze[p].n,_delta);
      updateFreezeOfOnInsertTotalFreeze_r11(p,newValue);
  }
  function updateFreezeOfOnInsertTotalFreeze_r11(address p,uint f) private    {
      TotalFreezeTuple memory toDelete = totalFreeze[p];
      if(toDelete._valid==true) {
        updateFreezeOfOnDeleteTotalFreeze_r11(p,toDelete.n);
      }
      TotalUnfreezeTuple memory totalUnfreezeTuple = totalUnfreeze[p];
      uint u = totalUnfreezeTuple.n;
      uint n = f-u;
      updateBalanceOfOnInsertFreezeOf_r13(p,n);
      freezeOf[p] = FreezeOfTuple(n,true);
  }
  function updateTotalSupplyOnIncrementAllBurn_r17(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r17(newValue);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r31(address o,address s,uint n) private    {
      int delta2 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r24(o,s,delta2);
      allowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnIncrementTotalOut_r13(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r13(p,newValue);
  }
  function updateAllowanceOnIncrementSpentTotal_r24(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r24(o,s,newValue);
  }
  function updateBalanceOfOnDeleteTotalOut_r13(address p,uint o) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      uint f = freezeOfTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateUnfreezeOnInsertRecv_unfreeze_r6(uint n) private   returns (bool) {
      address p = msg.sender;
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      uint m = freezeOfTuple.n;
      if(n<=m && n>0) {
        updateTotalUnfreezeOnInsertUnfreeze_r12(p,n);
        emit Unfreeze(p,n);
        return true;
      }
      return false;
  }
  function updateTotalBurnOnInsertBurn_r15(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r13(p,delta2);
      totalBurn[p].n += n;
  }
  function updateTransferOnInsertTransferFrom_r1(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r18(o,n);
      updateTotalInOnInsertTransfer_r29(r,n);
      emit Transfer(o,r,n);
  }
  function updateBalanceOfOnDeleteTotalBurn_r13(address p,uint m) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      uint f = freezeOfTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTransferOnInsertRecv_transfer_r7(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[s];
      uint m = balanceOfTuple.n;
      if(n<=m && n>0 && r!=address(0) && n+m>=m) {
        updateTotalOutOnInsertTransfer_r18(s,n);
        updateTotalInOnInsertTransfer_r29(r,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnInsertFreezeOf_r13(address p,uint f) private    {
      FreezeOfTuple memory toDelete = freezeOf[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteFreezeOf_r13(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalSupplyOnInsertAllBurn_r17(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateOwnerOnInsertConstructor_r33() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBurnOnInsertRecv_burn_r14(uint n) private   returns (bool) {
      address p = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint m = balanceOfTuple.n;
      if(p!=address(0) && n<=m) {
        updateTotalBurnOnInsertBurn_r15(p,n);
        updateAllBurnOnInsertBurn_r26(n);
        emit Burn(p,n);
        return true;
      }
      return false;
  }
  function updateAllowanceOnDeleteAllowanceTotal_r24(address o,address s,uint m) private    {
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      uint n = m-l;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateAllowanceOnInsertAllowanceTotal_r24(address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r24(o,s,toDelete.m);
      }
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateTotalMintOnInsertConstructor_r30(uint n) private    {
      address s = msg.sender;
      totalMint[s] = TotalMintTuple(n,true);
  }
  function updateBalanceOfOnInsertTotalBurn_r13(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r13(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      uint f = freezeOfTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateAllowanceOnInsertSpentTotal_r24(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r24(o,s,toDelete.m);
      }
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o];
      uint m = allowanceTotalTuple.m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateAllMintOnInsertConstructor_r8(uint n) private    {
      allMint = AllMintTuple(n,true);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r32(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[r];
      uint q = balanceOfTuple.n;
      BalanceOfTuple memory balanceOfTuple = balanceOf[o];
      uint m = balanceOfTuple.n;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint k = allowanceTuple.n;
      if(m>=n && k>=n && r!=address(0) && n+q>=q) {
        updateSpentTotalOnInsertTransferFrom_r20(o,s,n);
        updateTransferOnInsertTransferFrom_r1(o,r,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnDeleteFreezeOf_r13(address p,uint f) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateFreezeOfOnDeleteTotalFreeze_r11(address p,uint f) private    {
      TotalUnfreezeTuple memory totalUnfreezeTuple = totalUnfreeze[p];
      uint u = totalUnfreezeTuple.n;
      uint n = f-u;
      updateBalanceOfOnDeleteFreezeOf_r13(p,n);
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      if(n==freezeOfTuple.n) {
        freezeOf[p] = FreezeOfTuple(0,false);
      }
  }
  function updateFreezeOfOnInsertTotalUnfreeze_r11(address p,uint u) private    {
      TotalUnfreezeTuple memory toDelete = totalUnfreeze[p];
      if(toDelete._valid==true) {
        updateFreezeOfOnDeleteTotalUnfreeze_r11(p,toDelete.n);
      }
      TotalFreezeTuple memory totalFreezeTuple = totalFreeze[p];
      uint f = totalFreezeTuple.n;
      uint n = f-u;
      updateBalanceOfOnInsertFreezeOf_r13(p,n);
      freezeOf[p] = FreezeOfTuple(n,true);
  }
  function updateBalanceOfOnInsertTotalIn_r13(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r13(p,toDelete.n);
      }
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      uint f = freezeOfTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateSendOnInsertWithdrawEther_r3(address p,uint n) private    {
      payable(p).send(n);
  }
  function updateTotalSupplyOnInsertConstructor_r5(uint n) private    {
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTotalBalancesOnInsertConstructor_r23(uint n) private    {
      // Empty()
  }
  function updateTotalInOnInsertTransfer_r29(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r13(p,delta0);
      totalIn[p].n += n;
  }
  function updateBalanceOfOnDeleteTotalIn_r13(address p,uint i) private    {
      FreezeOfTuple memory freezeOfTuple = freezeOf[p];
      uint f = freezeOfTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = (((n+i)-m)-o)-f;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalFreezeOnInsertFreeze_r0(address p,uint n) private    {
      int delta0 = int(n);
      updateFreezeOfOnIncrementTotalFreeze_r11(p,delta0);
      totalFreeze[p].n += n;
  }
  function updateBalanceOfOnIncrementTotalIn_r13(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r13(p,newValue);
  }
  function updateAllBurnOnInsertBurn_r26(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r17(delta1);
      allBurn.n += n;
  }
  function updateWithdrawEtherOnInsertRecv_withdrawEther_r21(uint n) private   returns (bool) {
      address p = owner.p;
      if(p==msg.sender) {
        updateSendOnInsertWithdrawEther_r3(p,n);
        emit WithdrawEther(p,n);
        return true;
      }
      return false;
  }
}