contract CappedCrowdSale {
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct RaisedTuple {
    uint n;
    bool _valid;
  }
  struct EndTuple {
    uint time;
    bool _valid;
  }
  struct AllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct FinalizedTuple {
    bool b;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct OnceFinalizeTuple {
    bool b;
    bool _valid;
  }
  struct TotalMintTuple {
    uint n;
    bool _valid;
  }
  struct CapTuple {
    uint n;
    bool _valid;
  }
  struct RateTuple {
    uint r;
    bool _valid;
  }
  struct StartTuple {
    uint time;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct SpentTotalTuple {
    uint m;
    bool _valid;
  }
  mapping(address=>TotalInTuple) totalIn;
  mapping(address=>TotalOutTuple) totalOut;
  mapping(address=>TotalBurnTuple) totalBurn;
  RaisedTuple raised;
  EndTuple end;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  FinalizedTuple finalized;
  OwnerTuple owner;
  OnceFinalizeTuple onceFinalize;
  mapping(address=>TotalMintTuple) totalMint;
  CapTuple cap;
  RateTuple rate;
  StartTuple start;
  TotalSupplyTuple totalSupply;
  event Finalize();
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event IncreaseAllowance(address p,address s,uint n);
  event BuyAfterFinalize();
  event Transfer(address from,address to,uint amount);
  constructor() public {
    updateTotalSupplyOnInsertConstructor_r1();
    updateOnceFinalizeOnInsertConstructor_r14();
    updateOwnerOnInsertConstructor_r5();
  }
  function burn(address p,uint amount) public    {
      bool r12 = updateBurnOnInsertRecv_burn_r12(p,amount);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r18 = updateTransferOnInsertRecv_transfer_r18(to,amount);
      if(r18==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function buyToken(address p,uint amount) public    {
      bool r8 = updateBuyTokenOnInsertRecv_buyToken_r8(p,amount);
      if(r8==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address p,uint amount) public    {
      bool r21 = updateMintOnInsertRecv_mint_r21(p,amount);
      if(r21==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r22 = updateIncreaseAllowanceOnInsertRecv_approve_r22(s,n);
      if(r22==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf(p);
      return n;
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance(p,s);
      return n;
  }
  function finalize() public    {
      bool r15 = updateFinalizeOnInsertRecv_finalize_r15();
      bool r25 = updateFinalizeOnInsertRecv_finalize_r25();
      if(r15==false && r25==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r23 = updateTransferFromOnInsertRecv_transferFrom_r23(from,to,amount);
      if(r23==false) {
        revert("Rule condition failed");
      }
  }
  function updateFinalizeOnInsertRecv_finalize_r15() private   returns (bool) {
      uint c = cap.n;
      address s = msg.sender;
      if(false==finalized.b) {
        uint m = raised.n;
        if(s==owner.p) {
          if(m>=c) {
            updateOnceFinalizeOnInsertFinalize_r13();
            updateFinalizedOnInsertFinalize_r17();
            emit Finalize();
            return true;
          }
        }
      }
      return false;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r23(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint k = allowance(o,s);
      uint m = balanceOf(o);
      if(m>=n && k>=n) {
        updateSpentTotalOnInsertTransferFrom_r4(o,s,n);
        updateTransferOnInsertTransferFrom_r0(o,r,s,n);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalBurn_r3(address p,int m) private    {
      // Empty()
  }
  function updateAllowanceOnIncrementAllowanceTotal_r20(address o,address s,int m) private    {
      // Empty()
  }
  function updateRaisedOnInsertBuyToken_r2(uint n) private    {
      raised.n += n;
  }
  function updateTotalOutOnInsertTransfer_r19(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r3(p,delta0);
      totalOut[p].n += n;
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r6(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r20(o,s,delta0);
      allowanceTotal[o][s].m += n;
  }
  function updateAllBurnOnInsertBurn_r24(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r11(delta0);
  }
  function updateTotalSupplyOnInsertConstructor_r1() private    {
      totalSupply = TotalSupplyTuple(0,true);
  }
  function updateAllowanceOnIncrementSpentTotal_r20(address o,address s,int l) private    {
      // Empty()
  }
  function updateTotalBurnOnInsertBurn_r9(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r3(p,delta0);
      totalBurn[p].n += n;
  }
  function updateBuyTokenOnInsertRecv_buyToken_r8(address p,uint m) private   returns (bool) {
      uint e = end.time;
      uint r = rate.r;
      if(false==finalized.b) {
        uint s = start.time;
        uint t = block.timestamp;
        if(p!=address(0) && t<e && m!=0 && t>s) {
          uint n = m*r;
          updateMintOnInsertBuyToken_r16(p,n);
          updateRaisedOnInsertBuyToken_r2(n);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalMint_r3(address p,int n) private    {
      // Empty()
  }
  function updateTotalSupplyOnIncrementAllBurn_r11(int b) private    {
      int _delta = int(-b);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function updateTotalMintOnInsertMint_r10(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMint_r3(p,delta0);
      totalMint[p].n += n;
  }
  function updateOnceFinalizeOnInsertConstructor_r14() private    {
      onceFinalize = OnceFinalizeTuple(false,true);
  }
  function updateBalanceOfOnIncrementTotalIn_r3(address p,int i) private    {
      // Empty()
  }
  function updateSpentTotalOnInsertTransferFrom_r4(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r20(o,s,delta0);
      spentTotal[o][s].m += n;
  }
  function updateMintOnInsertBuyToken_r16(address p,uint n) private    {
      updateTotalMintOnInsertMint_r10(p,n);
      updateAllMintOnInsertMint_r7(n);
      emit Mint(p,n);
  }
  function updateFinalizedOnInsertFinalize_r17() private    {
      finalized = FinalizedTuple(true,true);
  }
  function balanceOf(address p) private view  returns (uint) {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      return s;
  }
  function updateAllMintOnInsertMint_r7(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r11(delta0);
  }
  function updateTransferOnInsertRecv_transfer_r18(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf(s);
      if(n<=m) {
        updateTotalInOnInsertTransfer_r26(r,n);
        updateTotalOutOnInsertTransfer_r19(s,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllMint_r11(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function updateOwnerOnInsertConstructor_r5() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function allowance(address o,address s) private view  returns (uint) {
      uint l = spentTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      return n;
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,address _spender2,uint n) private    {
      updateTotalInOnInsertTransfer_r26(r,n);
      updateTotalOutOnInsertTransfer_r19(o,n);
      emit Transfer(o,r,n);
  }
  function updateOnceFinalizeOnInsertFinalize_r13() private    {
      onceFinalize = OnceFinalizeTuple(true,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBalanceOfOnIncrementTotalOut_r3(address p,int o) private    {
      // Empty()
  }
  function updateMintOnInsertRecv_mint_r21(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateTotalMintOnInsertMint_r10(p,n);
          updateAllMintOnInsertMint_r7(n);
          emit Mint(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalInOnInsertTransfer_r26(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r3(p,delta0);
      totalIn[p].n += n;
  }
  function updateBurnOnInsertRecv_burn_r12(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOf(p);
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r9(p,n);
          updateAllBurnOnInsertBurn_r24(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateFinalizeOnInsertRecv_finalize_r25() private   returns (bool) {
      address s = msg.sender;
      uint e = end.time;
      if(false==finalized.b) {
        if(s==owner.p) {
          uint t = block.timestamp;
          if(t>e) {
            updateOnceFinalizeOnInsertFinalize_r13();
            updateFinalizedOnInsertFinalize_r17();
            emit Finalize();
            return true;
          }
        }
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r22(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance(o,s);
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r6(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
}