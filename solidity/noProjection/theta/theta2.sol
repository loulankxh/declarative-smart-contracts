contract Theta {
  struct UnlockTimeTuple {
    uint t;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct AllMintTuple {
    uint n;
    bool _valid;
  }
  struct PrecirculatedTuple {
    bool b;
    bool _valid;
  }
  struct TotalBalancesTuple {
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
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  UnlockTimeTuple unlockTime;
  OwnerTuple owner;
  mapping(address=>PrecirculatedTuple) precirculated;
  AllMintTuple allMint;
  TotalBalancesTuple totalBalances;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  event AllowPrecirculation(address p,bool b);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event DisallowPrecirculation(address p,bool b);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(uint t) public {
    updateTotalBalancesOnInsertConstructor_r12();
    updateOwnerOnInsertConstructor_r19();
    updateUnlockTimeOnInsertConstructor_r8(t);
    updateTotalSupplyOnInsertConstructor_r3();
  }
  function getBalanceOf(address p) public view  returns (uint) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint n = balanceOfTuple.n;
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
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply();
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
      AllowanceTuple memory allowanceTuple = allowance[p][s];
      uint n = allowanceTuple.n;
      return n;
  }
  function mint(address p,uint amount) public    {
      bool r26 = updateMintOnInsertRecv_mint_r26(p,amount);
      if(r26==false) {
        revert("Rule condition failed");
      }
  }
  function updateBurnOnInsertRecv_burn_r9(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        BalanceOfTuple memory balanceOfTuple = balanceOf[p];
        uint m = balanceOfTuple.n;
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r20(p,n);
          updateAllBurnOnInsertBurn_r27(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateUnlockTimeOnInsertConstructor_r8(uint t) private    {
      unlockTime = UnlockTimeTuple(t,true);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r11(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[o];
      uint m = balanceOfTuple.n;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint k = allowanceTuple.n;
      if(m>=n && k>=n && canTransfer(o,r)) {
        updateSpentTotalOnInsertTransferFrom_r13(o,s,n);
        updateTransferOnInsertTransferFrom_r0(o,r,n);
        return true;
      }
      return false;
  }
  function updateTotalBalancesOnInsertConstructor_r12() private    {
      totalBalances = TotalBalancesTuple(0,true);
  }
  function updateTotalOutOnInsertTransfer_r23(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r10(p,delta0);
  }
  function updateBalanceOfOnIncrementTotalOut_r10(address p,int o) private    {
      int _delta = int(-o);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r28(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint m = allowanceTuple.n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r16(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateTotalMintOnInsertMint_r21(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMint_r10(p,delta0);
  }
  function updateTotalSupplyOnIncrementAllMint_r22(int m) private    {
      // Empty()
  }
  function updateAllBurnOnInsertBurn_r27(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r22(delta0);
      allBurn.n += n;
  }
  function updateTotalBurnOnInsertBurn_r20(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r10(p,delta0);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r16(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r25(o,s,delta0);
  }
  function updateBalanceOfOnIncrementTotalBurn_r10(address p,int m) private    {
      int _delta = int(-m);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTransferOnInsertRecv_transfer_r17(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[s];
      uint m = balanceOfTuple.n;
      if(n<=m && canTransfer(s,r)) {
        updateTotalOutOnInsertTransfer_r23(s,n);
        updateTotalInOnInsertTransfer_r15(r,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalIn_r10(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function totalSupply() private view  returns (uint) {
      uint b = allBurn.n;
      uint m = allMint.n;
      uint n = m-b;
      return n;
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
  function updateOwnerOnInsertConstructor_r19() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateTotalSupplyOnIncrementAllBurn_r22(int b) private    {
      // Empty()
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
  function updateAllowanceOnIncrementSpentTotal_r25(address o,address s,int l) private    {
      int _delta = int(-l);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateTotalInOnInsertTransfer_r15(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r10(p,delta0);
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
  function updateAllowPrecirculationOnInsertRecv_allowPrecirculation_r18(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updatePrecirculatedOnInsertAllowPrecirculation_r6(p,bool(true));
        emit AllowPrecirculation(p,true);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalMint_r10(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateAllMintOnInsertMint_r4(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r22(delta0);
      allMint.n += n;
  }
  function canTransfer(address p,address q) private view  returns (bool) {
      uint ut = unlockTime.t;
      uint t = block.timestamp;
      if(t>=ut) {
        return true;
      }
      PrecirculatedTuple memory precirculatedTuple = precirculated[q];
      if(true==precirculatedTuple.b) {
        PrecirculatedTuple memory precirculatedTuple = precirculated[p];
        if(true==precirculatedTuple.b) {
          return true;
        }
      }
      return false;
  }
  function updatePrecirculatedOnInsertAllowPrecirculation_r6(address p,bool b) private    {
      precirculated[p] = PrecirculatedTuple(b,true);
  }
  function updateSpentTotalOnInsertTransferFrom_r13(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r25(o,s,delta0);
  }
  function updateAllowanceOnIncrementAllowanceTotal_r25(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r23(o,n);
      updateTotalInOnInsertTransfer_r15(r,n);
      emit Transfer(o,r,n);
  }
  function updateTotalSupplyOnInsertConstructor_r3() private    {
      // Empty()
  }
}