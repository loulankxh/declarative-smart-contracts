contract Linktoken {
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
  struct ValidRecipientTuple {
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
  mapping(address=>TotalInTuple) totalIn;
  mapping(address=>TotalOutTuple) totalOut;
  mapping(address=>TotalBurnTuple) totalBurn;
  OwnerTuple owner;
  ValidRecipientTuple validRecipient;
  mapping(address=>mapping(address=>DecreaseAllowanceTotalTuple)) decreaseAllowanceTotal;
  mapping(address=>TotalMintTuple) totalMint;
  TotalSupplyTuple totalSupply;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  event TransferFrom(address from,address to,address spender,uint amount);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event DecreaseAllowance(address p,address s,uint n);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor(uint n) public {
    updateTotalInOnInsertConstructor_r13(n);
    updateOwnerOnInsertConstructor_r8();
    updateTotalSupplyOnInsertConstructor_r23(n);
    updateBalanceOfOnInsertConstructor_r5(n);
    updateTotalMintOnInsertConstructor_r19(n);
    updateTotalBalancesOnInsertConstructor_r27(n);
  }
  function burn(address p,uint amount) public    {
      bool r3 = updateBurnOnInsertRecv_burn_r3(p,amount);
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r26 = updateIncreaseAllowanceOnInsertRecv_approve_r26(s,n);
      if(r26==false) {
        revert("Rule condition failed");
      }
  }
  function decreaseApproval(address p,uint n) public    {
      bool r7 = updateDecreaseAllowanceOnInsertRecv_decreaseApproval_r7(p,n);
      if(r7==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function mint(address p,uint amount) public    {
      bool r9 = updateMintOnInsertRecv_mint_r9(p,amount);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r11 = updateTransferFromOnInsertRecv_transferFrom_r11(from,to,amount);
      if(r11==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r2 = updateTransferOnInsertRecv_transfer_r2(to,amount);
      if(r2==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance[p][s].n;
      return n;
  }
  function increaseApproval(address p,uint n) public    {
      bool r12 = updateIncreaseAllowanceOnInsertRecv_increaseApproval_r12(p,n);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r26(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      if(allowance(o,s,m) && validRecipient(s)) {
        uint d = n-m;
        updateAllowanceTotalOnInsertIncreaseAllowance_r28(o,s,d);
        emit IncreaseAllowance(o,s,d);
        return true;
      }
      return false;
  }
  function balanceOf(address p,uint n) private view  returns (bool) {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      return true;
      if(p==msg.sender) {
        if(n==constructor.n) {
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnInsertConstructor_r5(uint n) private    {
      address p = msg.sender;
      // Empty()
  }
  function updateSpentTotalOnInsertTransferFrom_r22(address o,address s,uint n) private    {
      spentTotal[o][s].m += n;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalSupplyOnInsertConstructor_r23(uint n) private    {
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTotalInOnInsertConstructor_r13(uint n) private    {
      address s = msg.sender;
      totalIn[s] = TotalInTuple(n,true);
  }
  function updateAllMintOnInsertMint_r0(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r17(delta0);
  }
  function updateTransferOnInsertTransferFrom_r14(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r20(o,n);
      updateTotalInOnInsertTransfer_r10(r,n);
      emit Transfer(o,r,n);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r28(address o,address s,uint n) private    {
      allowanceTotal[o][s].m += n;
  }
  function updateTotalMintOnInsertMint_r16(address p,uint n) private    {
      totalMint[p].n += n;
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseApproval_r12(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      if(validRecipient(s)) {
        updateAllowanceTotalOnInsertIncreaseAllowance_r28(o,s,n);
        emit IncreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r8() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateAllBurnOnInsertBurn_r25(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r17(delta0);
  }
  function updateTotalBurnOnInsertBurn_r15(address p,uint n) private    {
      totalBurn[p].n += n;
  }
  function updateTotalOutOnInsertTransfer_r20(address p,uint n) private    {
      totalOut[p].n += n;
  }
  function updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r6(address o,address s,uint n) private    {
      decreaseAllowanceTotal[o][s].m += n;
  }
  function updateMintOnInsertRecv_mint_r9(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateAllMintOnInsertMint_r0(n);
          updateTotalMintOnInsertMint_r16(p,n);
          emit Mint(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTransferOnInsertRecv_transfer_r2(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(n<=m && balanceOf(s,m) && validRecipient(r)) {
        updateTotalOutOnInsertTransfer_r20(s,n);
        updateTotalInOnInsertTransfer_r10(r,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateTotalMintOnInsertConstructor_r19(uint n) private    {
      address s = msg.sender;
      totalMint[s] = TotalMintTuple(n,true);
  }
  function updateTotalSupplyOnIncrementAllBurn_r17(int b) private    {
      int _delta = int(-b);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function validRecipient(address p) private view  returns (bool) {
      address t = address(this);
      if(p!=t && p!=address(0)) {
        return true;
      }
      return false;
  }
  function updateTotalInOnInsertTransfer_r10(address p,uint n) private    {
      totalIn[p].n += n;
  }
  function updateTotalSupplyOnIncrementAllMint_r17(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function allowance(address p,address s,uint n) private view  returns (bool) {
      uint d = decreaseAllowanceTotal[o][s].m;
      uint l = spentTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      return true;
      return false;
  }
  function updateTotalBalancesOnInsertConstructor_r27(uint n) private    {
      // Empty()
  }
  function updateTransferFromOnInsertRecv_transferFrom_r11(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(m>=n && k>=n && allowance(o,s,k) && validRecipient(r) && balanceOf(o,m)) {
        updateTransferOnInsertTransferFrom_r14(o,r,n);
        updateSpentTotalOnInsertTransferFrom_r22(o,s,n);
        emit TransferFrom(o,r,s,n);
        return true;
      }
      return false;
  }
  function updateBurnOnInsertRecv_burn_r3(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0) && n<=m && balanceOf(p,m)) {
          updateTotalBurnOnInsertBurn_r15(p,n);
          updateAllBurnOnInsertBurn_r25(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseApproval_r7(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      if(m>=n && validRecipient(s) && allowance(o,s,m)) {
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r6(o,s,n);
        emit DecreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
}