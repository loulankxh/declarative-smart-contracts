contract Theta {
  struct UnlockTimeTuple {
    uint t;
    bool _valid;
  }
  struct ControllerTuple {
    address p;
    bool _valid;
  }
  struct PrecirculatedTuple {
    bool b;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  UnlockTimeTuple unlockTime;
  ControllerTuple controller;
  mapping(address=>PrecirculatedTuple) precirculated;
  TotalSupplyTuple totalSupply;
  mapping(address=>BalanceOfTuple) balanceOf;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  event AllowPrecirculation(address p,bool b);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event DisallowPrecirculation(address p,bool b);
  event Transfer(address from,address to,uint amount);
  event UnlockTime(uint t);
  event IncreaseAllowance(address p,address s,uint n);
  constructor(uint t) public {
    updateControllerOnInsertConstructor_r23();
    updateTotalSupplyOnInsertConstructor_r1();
    updateTotalBalancesOnInsertConstructor_r22();
    updateUnlockTimeOnInsertConstructor_r6(t);
  }
  function allowPrecirculation(address p) public    {
      bool r24 = updateAllowPrecirculationOnInsertRecv_allowPrecirculation_r24(p);
      if(r24==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r8 = updateTransferFromOnInsertRecv_transferFrom_r8(from,to,amount);
      if(r8==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function disallowPrecirculation(address p) public    {
      bool r13 = updateDisallowPrecirculationOnInsertRecv_disallowPrecirculation_r13(p);
      if(r13==false) {
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
  function approve(address s,uint n) public    {
      bool r27 = updateIncreaseAllowanceOnInsertRecv_approve_r27(s,n);
      if(r27==false) {
        revert("Rule condition failed");
      }
  }
  function changeUnlockTime(uint t) public    {
      bool r30 = updateUnlockTimeOnInsertRecv_changeUnlockTime_r30(t);
      if(r30==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r12 = updateTransferOnInsertRecv_transfer_r12(to,amount);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address p,uint amount) public    {
      bool r25 = updateMintOnInsertRecv_mint_r25(p,amount);
      if(r25==false) {
        revert("Rule condition failed");
      }
  }
  function changeController(address n) public    {
      bool r15 = updateControllerOnInsertRecv_changeController_r15(n);
      if(r15==false) {
        revert("Rule condition failed");
      }
  }
  function burn(address p,uint amount) public    {
      bool r28 = updateBurnOnInsertRecv_burn_r28(p,amount);
      if(r28==false) {
        revert("Rule condition failed");
      }
  }
  function updatePrecirculatedOnInsertDisallowPrecirculation_r16(address p,bool b) private    {
      precirculated[p] = PrecirculatedTuple(b,true);
  }
  function updateUnlockTimeOnInsertRecv_changeUnlockTime_r30(uint n) private   returns (bool) {
      address s = controller.p;
      if(s==msg.sender) {
        unlockTime = UnlockTimeTuple(n,true);
        emit UnlockTime(n);
        return true;
      }
      return false;
  }
  function updateTransferOnInsertRecv_transfer_r12(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[s].n;
      if(n<=m && canTransfer(s,r)) {
        updateTotalOutOnInsertTransfer_r20(s,n);
        updateTotalInOnInsertTransfer_r11(r,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateUnlockTimeOnInsertConstructor_r6(uint t) private    {
      unlockTime = UnlockTimeTuple(t,true);
      emit UnlockTime(t);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r29(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r10(o,s,delta0);
  }
  function updateMintOnInsertRecv_mint_r25(address p,uint n) private   returns (bool) {
      address s = controller.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateTotalMintOnInsertMint_r18(p,n);
          updateAllMintOnInsertMint_r2(n);
          emit Mint(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalMintOnInsertMint_r18(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMint_r7(p,delta0);
  }
  function updateSpentTotalOnInsertTransferFrom_r9(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r10(o,s,delta0);
  }
  function updateAllMintOnInsertMint_r2(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r19(delta0);
  }
  function updatePrecirculatedOnInsertAllowPrecirculation_r4(address p,bool b) private    {
      precirculated[p] = PrecirculatedTuple(b,true);
  }
  function updateBalanceOfOnIncrementTotalOut_r7(address p,int o) private    {
      int _delta = int(-o);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalInOnInsertTransfer_r11(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r7(p,delta0);
  }
  function updateAllBurnOnInsertBurn_r26(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r19(delta0);
  }
  function updateBurnOnInsertRecv_burn_r28(address p,uint n) private   returns (bool) {
      address s = controller.p;
      if(s==msg.sender) {
        uint m = balanceOf[p].n;
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r17(p,n);
          updateAllBurnOnInsertBurn_r26(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateAllowanceOnIncrementAllowanceTotal_r10(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateDisallowPrecirculationOnInsertRecv_disallowPrecirculation_r13(address p) private   returns (bool) {
      address s = controller.p;
      if(s==msg.sender) {
        updatePrecirculatedOnInsertDisallowPrecirculation_r16(p,bool(false));
        emit DisallowPrecirculation(p,false);
        return true;
      }
      return false;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r8(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[o].n;
      uint k = allowance[o][s].n;
      if(m>=n && k>=n && canTransfer(o,r)) {
        updateSpentTotalOnInsertTransferFrom_r9(o,s,n);
        updateTransferOnInsertTransferFrom_r14(o,r,n);
        return true;
      }
      return false;
  }
  function updateTotalOutOnInsertTransfer_r20(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r7(p,delta0);
  }
  function updateTotalBurnOnInsertBurn_r17(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r7(p,delta0);
  }
  function updateTotalSupplyOnInsertConstructor_r1() private    {
      totalSupply = TotalSupplyTuple(0,true);
  }
  function updateBalanceOfOnIncrementTotalBurn_r7(address p,int m) private    {
      int _delta = int(-m);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r27(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r29(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateAllowPrecirculationOnInsertRecv_allowPrecirculation_r24(address p) private   returns (bool) {
      address s = controller.p;
      if(s==msg.sender) {
        updatePrecirculatedOnInsertAllowPrecirculation_r4(p,bool(true));
        emit AllowPrecirculation(p,true);
        return true;
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r19(int b) private    {
      int _delta = int(-b);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
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
  function updateBalanceOfOnIncrementTotalIn_r7(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalBalancesOnInsertConstructor_r22() private    {
      // Empty()
  }
  function updateTransferOnInsertTransferFrom_r14(address o,address r,uint n) private    {
      updateTotalInOnInsertTransfer_r11(r,n);
      updateTotalOutOnInsertTransfer_r20(o,n);
      emit Transfer(o,r,n);
  }
  function updateBalanceOfOnIncrementTotalMint_r7(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalSupplyOnIncrementAllMint_r19(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function updateAllowanceOnIncrementSpentTotal_r10(address o,address s,int l) private    {
      int _delta = int(-l);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateControllerOnInsertRecv_changeController_r15(address n) private   returns (bool) {
      address s = controller.p;
      if(s==msg.sender) {
        if(n!=address(0)) {
          controller = ControllerTuple(n,true);
          return true;
        }
      }
      return false;
  }
  function updateControllerOnInsertConstructor_r23() private    {
      address s = msg.sender;
      controller = ControllerTuple(s,true);
  }
}