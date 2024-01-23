contract Erc777 {
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct TotalMintTuple {
    uint n;
    bool _valid;
  }
  struct RevokedDefaultOperatorTuple {
    bool b;
    bool _valid;
  }
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct DefaultOperatorTuple {
    bool b;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct OperatorsTuple {
    bool b;
    bool _valid;
  }
  struct AllMintTuple {
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
  mapping(address=>TotalInTuple) totalIn;
  mapping(address=>TotalOutTuple) totalOut;
  mapping(address=>TotalBurnTuple) totalBurn;
  mapping(address=>TotalMintTuple) totalMint;
  mapping(address=>mapping(address=>OperatorsTuple)) operators;
  AllMintTuple allMint;
  mapping(address=>mapping(address=>RevokedDefaultOperatorTuple)) revokedDefaultOperator;
  AllBurnTuple allBurn;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  mapping(address=>DefaultOperatorTuple) defaultOperator;
  OwnerTuple owner;
  event OperatorBurn(address p,address s,uint n,uint data,uint operatorData);
  event TransferFrom(address from,address to,address spender,uint amount);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event Transfer(address o,address r,uint n,uint data,uint rdata,bool b);
  event IncreaseAllowance(address p,address s,uint n);
  event OperatorSend(address o,address r,address s,uint n,uint data,uint operatorData);
  event RevokedDefaultOperator(address p,address o,bool b);
  event Operators(address p,address o,bool b);
  constructor(uint name,uint symbol) public {
    updateOwnerOnInsertConstructor_r4();
    updateTotalSupplyOnInsertConstructor_r15();
  }
  function approve(address s,uint n) public    {
      bool r29 = updateIncreaseAllowanceOnInsertRecv_approve_r29(s,n);
      if(r29==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address p,uint amount) public    {
      bool r27 = updateMintOnInsertRecv_mint_r27(p,amount);
      if(r27==false) {
        revert("Rule condition failed");
      }
  }
  function getRevokedDefaultOperator(address p,address o) public view  returns (bool) {
      bool b = revokedDefaultOperator[p][o].b;
      return b;
  }
  function revokeDefaultOperator(address o) public    {
      bool r13 = updateRevokedDefaultOperatorOnInsertRecv_revokeDefaultOperator_r13(o);
      bool r22 = updateOperatorsOnInsertRecv_revokeDefaultOperator_r22(o);
      if(r13==false && r22==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance[p][s].n;
      return n;
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf(p);
      return n;
  }
  function getDefaultOperator(address p) public view  returns (bool) {
      bool b = defaultOperator[p].b;
      return b;
  }
  function burn(address p,uint amount) public    {
      bool r21 = updateBurnOnInsertRecv_burn_r21(p,amount);
      if(r21==false) {
        revert("Rule condition failed");
      }
  }
  function getOperators(address p,address o) public view  returns (bool) {
      bool b = operators[p][o].b;
      return b;
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply();
      return n;
  }
  function authorizeOperator(address o) public    {
      bool r24 = updateOperatorsOnInsertRecv_authorizeOperator_r24(o);
      bool r7 = updateRevokedDefaultOperatorOnInsertRecv_authorizeOperator_r7(o);
      if(r24==false && r7==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r30 = updateTransferFromOnInsertRecv_transferFrom_r30(from,to,amount);
      if(r30==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address r,uint amount) public    {
      bool r9 = updateTransferOnInsertRecv_transfer_r9(r,amount);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r8(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r26(o,s,delta0);
  }
  function updateTransferOnInsertRecv_transfer_r9(address r,uint amount) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf(s);
      if(amount<=m) {
        updateTotalInOnInsertTransfer_r0(r,n);
        updateTotalOutOnInsertTransfer_r1(s,n);
        emit Transfer(s,r,n,0,0,false);
        return true;
      }
      return false;
  }
  function updateSpentTotalOnInsertTransferFrom_r23(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r26(o,s,delta0);
  }
  function balanceOf(address p) private view  returns (uint) {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      return s;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateRevokedDefaultOperatorOnInsertRecv_revokeDefaultOperator_r13(address o) private   returns (bool) {
      address p = msg.sender;
      if(true==defaultOperator[o].b) {
        if(p!=o) {
          revokedDefaultOperator[p][o] = RevokedDefaultOperatorTuple(true,true);
          emit RevokedDefaultOperator(p,o,true);
          return true;
        }
      }
      return false;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r30(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint k = allowance[o][s].n;
      uint m = balanceOf(o);
      if(m>=n && k>=n) {
        updateTransferOnInsertTransferFrom_r11(o,r,n);
        updateSpentTotalOnInsertTransferFrom_r23(o,s,n);
        emit TransferFrom(o,r,s,n);
        return true;
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r29(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r8(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateRevokedDefaultOperatorOnInsertRecv_authorizeOperator_r7(address o) private   returns (bool) {
      address p = msg.sender;
      if(true==defaultOperator[o].b) {
        if(p!=o) {
          revokedDefaultOperator[o][p] = RevokedDefaultOperatorTuple(false,true);
          emit RevokedDefaultOperator(o,p,false);
          return true;
        }
      }
      return false;
  }
  function updateTransferOnInsertTransferFrom_r11(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r1(o,n);
      updateTotalInOnInsertTransfer_r0(r,n);
      emit Transfer(o,r,n,0,0,false);
  }
  function updateAllowanceOnIncrementAllowanceTotal_r26(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateAllBurnOnInsertBurn_r31(uint n) private    {
      allBurn.n += n;
  }
  function updateTotalSupplyOnInsertConstructor_r15() private    {
      // Empty()
  }
  function totalSupply() private view  returns (uint) {
      uint b = allBurn.n;
      uint m = allMint.n;
      uint n = m-b;
      return n;
  }
  function updateBurnOnInsertRecv_burn_r21(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOf(p);
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r16(p,n);
          updateAllBurnOnInsertBurn_r31(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalMintOnInsertMint_r17(address p,uint n) private    {
      totalMint[p].n += n;
  }
  function updateOperatorsOnInsertRecv_authorizeOperator_r24(address o) private   returns (bool) {
      address p = msg.sender;
      if(false==defaultOperator[o].b) {
        if(p!=o) {
          operators[p][o] = OperatorsTuple(true,true);
          emit Operators(p,o,true);
          return true;
        }
      }
      return false;
  }
  function updateAllowanceOnIncrementSpentTotal_r26(address o,address s,int l) private    {
      int _delta = int(-l);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateTotalBurnOnInsertBurn_r16(address p,uint n) private    {
      totalBurn[p].n += n;
  }
  function updateMintOnInsertRecv_mint_r27(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateTotalMintOnInsertMint_r17(p,n);
          updateAllMintOnInsertMint_r14(n);
          emit Mint(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalOutOnInsertTransfer_r1(address p,uint n) private    {
      totalOut[p].n += n;
  }
  function updateAllMintOnInsertMint_r14(uint n) private    {
      allMint.n += n;
  }
  function updateTotalInOnInsertTransfer_r0(address p,uint n) private    {
      totalIn[p].n += n;
  }
  function updateOperatorsOnInsertRecv_revokeDefaultOperator_r22(address o) private   returns (bool) {
      address p = msg.sender;
      if(false==defaultOperator[o].b) {
        if(p!=o) {
          operators[p][o] = OperatorsTuple(false,true);
          emit Operators(p,o,false);
          return true;
        }
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r4() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
}