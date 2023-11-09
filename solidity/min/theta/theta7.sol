contract Theta {
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct CanTransferTuple {
    address p;
    address q;
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
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  OwnerTuple owner;
  TotalSupplyTuple totalSupply;
  CanTransferTuple canTransfer;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>BalanceOfTuple) balanceOf;
  event TransferFrom(address from,address to,address spender,uint amount);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event Precirculated(address p,bool b);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(uint t) public {
    updateTotalSupplyOnInsertConstructor_r3();
    updateUnlockTimeOnInsertConstructor_r7(t);
    updateOwnerOnInsertConstructor_r2();
    updateTotalBalancesOnInsertConstructor_r20();
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
  function updatePrecirculatedOnInsertRecv_allowPrecirculation_r19(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        emit Precirculated(p,true);
        return true;
      }
      return false;
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r13(address o,address s,uint n) private    {
      allowanceTotal[o][s].m += n;
  }
  function updateTotalInOnInsertTransfer_r12(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r9(p,delta0);
  }
  function updateBalanceOfOnIncrementTotalIn_r9(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r10(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[o].n;
      if(m>=n && k>=n && allowance(o,s,k) && canTransfer(o,r)) {
        updateSpentTotalOnInsertTransferFrom_r11(o,s,n);
        updateTransferOnInsertTransferFrom_r0(o,r,n);
        emit TransferFrom(o,r,s,n);
        return true;
      }
      return false;
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
  function updateBalanceOfOnIncrementTotalBurn_r9(address p,int m) private    {
      int _delta = int(-m);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
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
  function updateSpentTotalOnInsertTransferFrom_r11(address o,address s,uint n) private    {
      spentTotal[o][s].m += n;
  }
  function updateTotalMintOnInsertMint_r15(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMint_r9(p,delta0);
  }
  function allowance(address p,address s,uint n) private view  returns (bool) {
      uint l = spentTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      return true;
      return false;
  }
  function updateTotalOutOnInsertTransfer_r17(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r9(p,delta0);
  }
  function canTransfer(address p,address q) private view  returns (bool) {
      uint t = block.timestamp;
      if(t>=ut && unlockTime(ut)) {
        return true;
      }
      if(true==precirculated[q].b) {
        if(true==precirculated[p].b) {
          return true;
        }
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r16(int b) private    {
      int _delta = int(-b);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function unlockTime(uint t) private view  returns (bool) {
      if(t==constructor.t) {
        return true;
      }
      return false;
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
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateAllMintOnInsertMint_r4(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r16(delta0);
  }
  function updateBalanceOfOnIncrementTotalOut_r9(address p,int o) private    {
      int _delta = int(-o);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r24(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      if(allowance(o,s,m)) {
        uint d = n-m;
        updateAllowanceTotalOnInsertIncreaseAllowance_r13(o,s,d);
        emit IncreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function updateTotalBurnOnInsertBurn_r14(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r9(p,delta0);
  }
  function updateTotalSupplyOnIncrementAllMint_r16(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function updateOwnerOnInsertConstructor_r2() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateUnlockTimeOnInsertConstructor_r7(uint t) private    {
      // Empty()
  }
  function updateAllBurnOnInsertBurn_r23(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r16(delta0);
  }
  function updateTotalBalancesOnInsertConstructor_r20() private    {
      // Empty()
  }
  function updateTotalSupplyOnInsertConstructor_r3() private    {
      totalSupply = TotalSupplyTuple(0,true);
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r17(o,n);
      updateTotalInOnInsertTransfer_r12(r,n);
      emit Transfer(o,r,n);
  }
  function updatePrecirculatedOnInsertRecv_disallowPrecirculation_r26(address p) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        emit Precirculated(p,false);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalMint_r9(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
}