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
  struct AllMintTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
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
  mapping(address=>TotalBurnTuple) totalBurn;
  RaisedTuple raised;
  EndTuple end;
  mapping(address=>TotalMintTuple) totalMint;
  AllMintTuple allMint;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  FinalizedTuple finalized;
  OwnerTuple owner;
  CapTuple cap;
  RateTuple rate;
  StartTuple start;
  TotalSupplyTuple totalSupply;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
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
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance[p][s].n;
      return n;
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function approve(address s,uint n) public    {
      bool r22 = updateIncreaseAllowanceOnInsertRecv_approve_r22(s,n);
      if(r22==false) {
        revert("Rule condition failed");
      }
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
  function updateBalanceOfOnIncrementTotalOut_r3(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r3(p,newValue);
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
  function updateAllowanceOnInsertSpentTotal_r20(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r20(o,s,toDelete.m);
      }
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateTotalSupplyOnIncrementAllBurn_r11(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r11(newValue);
  }
  function updateBalanceOfOnInsertTotalIn_r3(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r3(p,toDelete.n);
      }
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r6(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r20(o,s,delta1);
      allowanceTotal[o][s].m += n;
  }
  function updateBalanceOfOnIncrementTotalBurn_r3(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r3(p,newValue);
  }
  function updateRaisedOnInsertBuyToken_r2(uint n) private    {
      raised.n += n;
  }
  function updateTotalMintOnInsertMint_r10(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalMint_r3(p,delta1);
      totalMint[p].n += n;
  }
  function updateTotalBurnOnInsertBurn_r9(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r3(p,delta1);
      totalBurn[p].n += n;
  }
  function updateTotalInOnInsertTransfer_r26(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r3(p,delta0);
      totalIn[p].n += n;
  }
  function updateTotalSupplyOnIncrementAllMint_r11(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r11(newValue);
  }
  function updateTotalSupplyOnInsertAllMint_r11(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
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
  function updateBalanceOfOnDeleteTotalBurn_r3(address p,uint m) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateOnceFinalizeOnInsertConstructor_r14() private    {
      // Empty()
  }
  function updateBalanceOfOnInsertTotalMint_r3(address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r3(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateAllowanceOnIncrementSpentTotal_r20(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r20(o,s,newValue);
  }
  function updateSpentTotalOnInsertTransferFrom_r4(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r20(o,s,delta0);
      spentTotal[o][s].m += n;
  }
  function updateTotalSupplyOnInsertAllBurn_r11(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTransferOnInsertRecv_transfer_r18(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[s].n;
      if(n<=m) {
        updateTotalInOnInsertTransfer_r26(r,n);
        updateTotalOutOnInsertTransfer_r19(s,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateAllowanceOnIncrementAllowanceTotal_r20(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r20(o,s,newValue);
  }
  function updateBalanceOfOnInsertTotalOut_r3(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r3(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnDeleteTotalOut_r3(address p,uint o) private    {
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateMintOnInsertBuyToken_r16(address p,uint n) private    {
      updateTotalMintOnInsertMint_r10(p,n);
      updateAllMintOnInsertMint_r7(n);
      emit Mint(p,n);
  }
  function updateFinalizedOnInsertFinalize_r17() private    {
      finalized = FinalizedTuple(true,true);
  }
  function updateTotalOutOnInsertTransfer_r19(address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalOut_r3(p,delta1);
      totalOut[p].n += n;
  }
  function updateBalanceOfOnInsertTotalBurn_r3(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r3(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateOwnerOnInsertConstructor_r5() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,address _spender2,uint n) private    {
      updateTotalInOnInsertTransfer_r26(r,n);
      updateTotalOutOnInsertTransfer_r19(o,n);
      emit Transfer(o,r,n);
  }
  function updateBalanceOfOnIncrementTotalMint_r3(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r3(p,newValue);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r22(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r6(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateAllowanceOnDeleteSpentTotal_r20(address o,address s,uint l) private    {
      uint m = allowanceTotal[o][s].m;
      uint n = m-l;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateAllowanceOnDeleteAllowanceTotal_r20(address o,address s,uint m) private    {
      uint l = spentTotal[o][s].m;
      uint n = m-l;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateAllowanceOnInsertAllowanceTotal_r20(address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r20(o,s,toDelete.m);
      }
      uint l = spentTotal[o][s].m;
      uint n = m-l;
      allowance[o][s] = AllowanceTuple(n,true);
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
  function updateBurnOnInsertRecv_burn_r12(address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOf[p].n;
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r9(p,n);
          updateAllBurnOnInsertBurn_r24(n);
          emit Burn(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalSupplyOnInsertConstructor_r1() private    {
      totalSupply = TotalSupplyTuple(0,true);
  }
  function updateOnceFinalizeOnInsertFinalize_r13() private    {
      // Empty()
  }
  function updateBalanceOfOnDeleteTotalMint_r3(address p,uint n) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateAllMintOnInsertMint_r7(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r11(delta0);
      allMint.n += n;
  }
  function updateBalanceOfOnIncrementTotalIn_r3(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r3(p,newValue);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r23(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint k = allowance[o][s].n;
      uint m = balanceOf[o].n;
      if(m>=n && k>=n) {
        updateSpentTotalOnInsertTransferFrom_r4(o,s,n);
        updateTransferOnInsertTransferFrom_r0(o,r,s,n);
        return true;
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
  function updateBalanceOfOnDeleteTotalIn_r3(address p,uint i) private    {
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateAllBurnOnInsertBurn_r24(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r11(delta1);
      allBurn.n += n;
  }
}