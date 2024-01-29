contract Theta {
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct UnlockTimeTuple {
    uint t;
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
  struct AllMintTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  struct SpentTotalTuple {
    uint m;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct PrecirculatedTuple {
    bool b;
    bool _valid;
  }
  struct AllBurnTuple {
    uint n;
    bool _valid;
  }
  mapping(address=>TotalInTuple) totalIn;
  mapping(address=>TotalOutTuple) totalOut;
  UnlockTimeTuple unlockTime;
  mapping(address=>TotalBurnTuple) totalBurn;
  OwnerTuple owner;
  mapping(address=>TotalMintTuple) totalMint;
  mapping(address=>PrecirculatedTuple) precirculated;
  AllMintTuple allMint;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  AllBurnTuple allBurn;
  event AllowPrecirculation(address p,bool b);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event DisallowPrecirculation(address p,bool b);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(uint t) public {
    updateOwnerOnInsertConstructor_r19();
    updateTotalBalancesOnInsertConstructor_r12();
    updateUnlockTimeOnInsertConstructor_r8(t);
    updateTotalSupplyOnInsertConstructor_r3();
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply();
      return n;
  }
  function allowPrecirculation(address p) public    {
      bool r18 = updateAllowPrecirculationOnInsertRecv_allowPrecirculation_r18(p);
      if(r18==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r11 = updateTransferFromOnInsertRecv_transferFrom_r11(from,to,amount);
      if(r11==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf(p);
      return n;
  }
  function disallowPrecirculation(address p) public    {
      bool r14 = updateDisallowPrecirculationOnInsertRecv_disallowPrecirculation_r14(p);
      if(r14==false) {
        revert("Rule condition failed");
      }
  }
  function burn(address p,uint amount) public    {
      bool r9 = updateBurnOnInsertRecv_burn_r9(p,amount);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r28 = updateIncreaseAllowanceOnInsertRecv_approve_r28(s,n);
      if(r28==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r17 = updateTransferOnInsertRecv_transfer_r17(to,amount);
      if(r17==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance(p,s);
      return n;
  }
  function mint(address p,uint amount) public    {
      bool r26 = updateMintOnInsertRecv_mint_r26(p,amount);
      if(r26==false) {
        revert("Rule condition failed");
      }
  }
  function updateBalanceOfOnIncrementTotalMint_r10(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r10(p,newValue);
  }
  function balanceOf(address p) private view  returns (uint) {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      return s;
  }
  function updateAllowPrecirculationOnInsertRecv_allowPrecirculation_r18(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updatePrecirculatedOnInsertAllowPrecirculation_r6(p,bool(true));
        emit AllowPrecirculation(p,true);
        return true;
      }
      return false;
  }
  function updatePrecirculatedOnInsertAllowPrecirculation_r6(address p,bool b) private    {
      precirculated[p] = PrecirculatedTuple(b,true);
  }
  function updateBalanceOfOnDeleteTotalMint_r10(address p,uint n) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateAllBurnOnInsertBurn_r27(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r22(delta0);
      allBurn.n += n;
  }
  function updateBalanceOfOnIncrementTotalBurn_r10(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r10(p,newValue);
  }
  function updateBalanceOfOnInsertTotalOut_r10(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r10(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateUnlockTimeOnInsertConstructor_r8(uint t) private    {
      unlockTime = UnlockTimeTuple(t,true);
  }
  function updateBalanceOfOnIncrementTotalOut_r10(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r10(p,newValue);
  }
  function updateTotalBurnOnInsertBurn_r20(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r10(p,delta1);
      totalBurn[p].n += n;
  }
  function updateBalanceOfOnDeleteTotalIn_r10(address p,uint i) private    {
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateTotalSupplyOnIncrementAllMint_r22(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r22(newValue);
  }
  function totalSupply() private view  returns (uint) {
      uint b = allBurn.n;
      uint m = allMint.n;
      uint n = m-b;
      return n;
  }
  function updateOwnerOnInsertConstructor_r19() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateAllowanceOnInsertAllowanceTotal_r25(address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r25(o,s,toDelete.m);
      }
      uint l = spentTotal[o][s].m;
      uint n = m-l;
  }
  function updateTotalSupplyOnInsertAllMint_r22(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
  }
  function updateTotalMintOnInsertMint_r21(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalMint_r10(p,delta2);
      totalMint[p].n += n;
  }
  function updateBalanceOfOnIncrementTotalIn_r10(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r10(p,newValue);
  }
  function updateAllowanceOnIncrementSpentTotal_r25(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r25(o,s,newValue);
  }
  function updateTotalSupplyOnIncrementAllBurn_r22(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r22(newValue);
  }
  function updateBalanceOfOnInsertTotalMint_r10(address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r10(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateTotalSupplyOnInsertAllBurn_r22(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
  }
  function updateBalanceOfOnInsertTotalIn_r10(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r10(p,toDelete.n);
      }
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateAllowanceOnIncrementAllowanceTotal_r25(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r25(o,s,newValue);
  }
  function updateAllowanceOnInsertSpentTotal_r25(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r25(o,s,toDelete.m);
      }
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
  }
  function updateAllowanceOnDeleteSpentTotal_r25(address o,address s,uint l) private    {
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
  }
  function allowance(address o,address s) private view  returns (uint) {
      uint l = spentTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      return n;
  }
  function updatePrecirculatedOnInsertDisallowPrecirculation_r2(address p,bool b) private    {
      precirculated[p] = PrecirculatedTuple(b,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateDisallowPrecirculationOnInsertRecv_disallowPrecirculation_r14(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updatePrecirculatedOnInsertDisallowPrecirculation_r2(p,bool(false));
        emit DisallowPrecirculation(p,false);
        return true;
      }
      return false;
  }
  function updateBurnOnInsertRecv_burn_r9(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOf(p);
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r20(p,n);
          updateAllBurnOnInsertBurn_r27(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateMintOnInsertRecv_mint_r26(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateTotalMintOnInsertMint_r21(p,n);
          updateAllMintOnInsertMint_r4(n);
          emit Mint(p,n);
          return true;
        }
      }
      return false;
  }
  function updateAllMintOnInsertMint_r4(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r22(delta0);
      allMint.n += n;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r11(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf(o);
      uint k = allowance(o,s);
      if(m>=n && k>=n && canTransfer(o,r)) {
        updateSpentTotalOnInsertTransferFrom_r13(o,s,n);
        updateTransferOnInsertTransferFrom_r0(o,r,n);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertRecv_transfer_r17(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf(s);
      if(n<=m && canTransfer(s,r)) {
        updateTotalOutOnInsertTransfer_r23(s,n);
        updateTotalInOnInsertTransfer_r15(r,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnDeleteTotalBurn_r10(address p,uint m) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateSpentTotalOnInsertTransferFrom_r13(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r25(o,s,delta0);
      spentTotal[o][s].m += n;
  }
  function updateBalanceOfOnDeleteTotalOut_r10(address p,uint o) private    {
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r28(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance(o,s);
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r16(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function canTransfer(address p,address q) private view  returns (bool) {
      uint ut = unlockTime.t;
      uint t = block.timestamp;
      if(t>=ut) {
        return true;
      }
      if(true==precirculated[q].b) {
        if(true==precirculated[p].b) {
          return true;
        }
      }
      return false;
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r23(o,n);
      updateTotalInOnInsertTransfer_r15(r,n);
      emit Transfer(o,r,n);
  }
  function updateTotalSupplyOnInsertConstructor_r3() private    {
      // Empty()
  }
  function updateAllowanceOnDeleteAllowanceTotal_r25(address o,address s,uint m) private    {
      uint l = spentTotal[o][s].m;
      uint n = m-l;
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r16(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r25(o,s,delta1);
      allowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnInsertTotalBurn_r10(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r10(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateTotalInOnInsertTransfer_r15(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r10(p,delta0);
      totalIn[p].n += n;
  }
  function updateTotalBalancesOnInsertConstructor_r12() private    {
      // Empty()
  }
  function updateTotalOutOnInsertTransfer_r23(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r10(p,delta0);
      totalOut[p].n += n;
  }
}