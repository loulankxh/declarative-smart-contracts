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
  struct TotalSupplyTuple {
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
  struct AllowanceTuple {
    uint n;
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
  UnlockTimeTuple unlockTime;
  mapping(address=>TotalBurnTuple) totalBurn;
  mapping(address=>TotalMintTuple) totalMint;
  mapping(address=>PrecirculatedTuple) precirculated;
  TotalSupplyTuple totalSupply;
  AllMintTuple allMint;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  OwnerTuple owner;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event Precirculated(address p,bool b);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(uint t) public {
    updateOwnerOnInsertConstructor_r2(t);
    updateUnlockTimeOnInsertConstructor_r7(t);
    updateTotalSupplyOnInsertConstructor_r3(t);
    updateTotalBalancesOnInsertConstructor_r20(t);
  }
  function transfer(address to,uint amount) public    {
      bool r25 = updateTransferOnInsertRecv_transfer_r25(to,amount);
      if(r25==false) {
        revert("Rule condition failed");
      }
  }
  function disallowPrecirculation(address p) public    {
      bool r26 = updatePrecirculatedOnInsertRecv_disallowPrecirculation_r26(p);
      if(r26==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r24 = updateIncreaseAllowanceOnInsertRecv_approve_r24(s,n);
      if(r24==false) {
        revert("Rule condition failed");
      }
  }
  function allowPrecirculation(address p) public    {
      bool r19 = updatePrecirculatedOnInsertRecv_allowPrecirculation_r19(p);
      if(r19==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r10 = updateTransferFromOnInsertRecv_transferFrom_r10(from,to,amount);
      if(r10==false) {
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
  function burn(address p,uint amount) public    {
      bool r8 = updateBurnOnInsertRecv_burn_r8(p,amount);
      if(r8==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address p,uint amount) public    {
      bool r22 = updateMintOnInsertRecv_mint_r22(p,amount);
      if(r22==false) {
        revert("Rule condition failed");
      }
  }
  function updateTotalSupplyOnInsertConstructor_r3(uint _t0) private    {
      totalSupply = TotalSupplyTuple(0,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r13(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r21(o,s,delta1);
      allowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnDeleteTotalOut_r9(address p,uint o) private    {
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalBalancesOnInsertConstructor_r20(uint _t0) private    {
      // Empty()
  }
  function updateMintOnInsertRecv_mint_r22(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateTotalMintOnInsertMint_r15(p,n);
          updateAllMintOnInsertMint_r4(n);
          emit Mint(p,n);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalIn_r9(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r9(p,newValue);
  }
  function updateBalanceOfOnDeleteTotalIn_r9(address p,uint i) private    {
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalSupplyOnInsertAllMint_r16(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTotalSupplyOnIncrementAllMint_r16(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r16(newValue);
  }
  function updateAllowanceOnIncrementSpentTotal_r21(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r21(o,s,newValue);
  }
  function updateAllowanceOnInsertAllowanceTotal_r21(address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r21(o,s,toDelete.m);
      }
      uint l = spentTotal[o][s].m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateBalanceOfOnDeleteTotalMint_r9(address p,uint n) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalOutOnInsertTransfer_r17(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalOut_r9(p,delta2);
      totalOut[p].n += n;
  }
  function updateSpentTotalOnInsertTransferFrom_r11(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementSpentTotal_r21(o,s,delta1);
      spentTotal[o][s].m += n;
  }
  function updateAllMintOnInsertMint_r4(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r16(delta0);
      allMint.n += n;
  }
  function updateBalanceOfOnIncrementTotalOut_r9(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r9(p,newValue);
  }
  function updateBalanceOfOnInsertTotalBurn_r9(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r9(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateUnlockTimeOnInsertConstructor_r7(uint t) private    {
      unlockTime = UnlockTimeTuple(t,true);
  }
  function updateTotalSupplyOnInsertAllBurn_r16(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTotalBurnOnInsertBurn_r14(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r9(p,delta2);
      totalBurn[p].n += n;
  }
  function updateAllBurnOnInsertBurn_r23(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r16(delta1);
      allBurn.n += n;
  }
  function updateBurnOnInsertRecv_burn_r8(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOf[p].n;
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r14(p,n);
          updateAllBurnOnInsertBurn_r23(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateAllowanceOnInsertSpentTotal_r21(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r21(o,s,toDelete.m);
      }
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateBalanceOfOnIncrementTotalMint_r9(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r9(p,newValue);
  }
  function updateAllowanceOnIncrementAllowanceTotal_r21(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r21(o,s,newValue);
  }
  function updatePrecirculatedOnInsertRecv_allowPrecirculation_r19(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        precirculated[p] = PrecirculatedTuple(true,true);
        emit Precirculated(p,true);
        return true;
      }
      return false;
  }
  function updatePrecirculatedOnInsertRecv_disallowPrecirculation_r26(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        precirculated[p] = PrecirculatedTuple(false,true);
        emit Precirculated(p,false);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,address _spender2,uint n) private    {
      updateTotalOutOnInsertTransfer_r17(o,n);
      updateTotalInOnInsertTransfer_r12(r,n);
      emit Transfer(o,r,n);
  }
  function updateBalanceOfOnInsertTotalIn_r9(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r9(p,toDelete.n);
      }
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalInOnInsertTransfer_r12(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalIn_r9(p,delta1);
      totalIn[p].n += n;
  }
  function updateBalanceOfOnDeleteTotalBurn_r9(address p,uint m) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalMintOnInsertMint_r15(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalMint_r9(p,delta1);
      totalMint[p].n += n;
  }
  function updateBalanceOfOnInsertTotalOut_r9(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r9(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnIncrementTotalBurn_r9(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r9(p,newValue);
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r24(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r13(o,s,d);
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
  function updateAllowanceOnDeleteAllowanceTotal_r21(address o,address s,uint m) private    {
      uint l = spentTotal[o][s].m;
      uint n = m-l;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateTransferFromOnInsertRecv_transferFrom_r10(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[o].n;
      uint k = allowance[o][s].n;
      if(m>=n && k>=n && canTransfer(o,r)) {
        updateSpentTotalOnInsertTransferFrom_r11(o,s,n);
        updateTransferOnInsertTransferFrom_r0(o,r,s,n);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertRecv_transfer_r25(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[s].n;
      if(n<=m && canTransfer(s,r)) {
        updateTotalOutOnInsertTransfer_r17(s,n);
        updateTotalInOnInsertTransfer_r12(r,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r2(uint _t0) private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateAllowanceOnDeleteSpentTotal_r21(address o,address s,uint l) private    {
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateBalanceOfOnInsertTotalMint_r9(address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r9(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalSupplyOnIncrementAllBurn_r16(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r16(newValue);
  }
}