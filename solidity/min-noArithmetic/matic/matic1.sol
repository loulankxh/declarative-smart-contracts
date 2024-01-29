contract Matic {
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
  struct DecreaseAllowanceTotalTuple {
    uint m;
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
  struct IsPauserTuple {
    bool b;
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
  struct AllBurnTuple {
    uint n;
    bool _valid;
  }
  struct PausedTuple {
    bool b;
    bool _valid;
  }
  mapping(address=>TotalInTuple) totalIn;
  mapping(address=>TotalOutTuple) totalOut;
  mapping(address=>TotalBurnTuple) totalBurn;
  OwnerTuple owner;
  mapping(address=>mapping(address=>DecreaseAllowanceTotalTuple)) decreaseAllowanceTotal;
  mapping(address=>TotalMintTuple) totalMint;
  AllMintTuple allMint;
  mapping(address=>IsPauserTuple) isPauser;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  AllBurnTuple allBurn;
  PausedTuple paused;
  event Burn(address p,uint amount);
  event RenouncePauser(address p,bool b);
  event Mint(address p,uint amount);
  event Unpause(bool b);
  event DecreaseAllowance(address p,address s,uint n);
  event AddPauser(address p,bool b);
  event Transfer(address from,address to,uint amount);
  event IncreaseAllowance(address p,address s,uint n);
  event Pause(bool b);
  constructor(uint n) public {
    updateIsPauserOnInsertConstructor_r7();
    updatePausedOnInsertConstructor_r28();
    updateAllMintOnInsertConstructor_r16(n);
    updateTotalBalancesOnInsertConstructor_r36(n);
    updateOwnerOnInsertConstructor_r9();
    updateTotalMintOnInsertConstructor_r23(n);
    updateTotalSupplyOnInsertConstructor_r31(n);
    updateBalanceOfOnInsertConstructor_r6(n);
  }
  function burn(address p,uint amount) public    {
      bool r12 = updateBurnOnInsertRecv_burn_r12(p,amount);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r15 = updateTransferOnInsertRecv_transfer_r15(to,amount);
      if(r15==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply();
      return n;
  }
  function approve(address s,uint n) public    {
      bool r35 = updateIncreaseAllowanceOnInsertRecv_approve_r35(s,n);
      if(r35==false) {
        revert("Rule condition failed");
      }
  }
  function pause() public    {
      bool r20 = updatePauseOnInsertRecv_pause_r20();
      if(r20==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r2 = updateTransferFromOnInsertRecv_transferFrom_r2(from,to,amount);
      if(r2==false) {
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
  function addPauser(address p) public    {
      bool r25 = updateAddPauserOnInsertRecv_addPauser_r25(p);
      if(r25==false) {
        revert("Rule condition failed");
      }
  }
  function increaseAllowance(address p,uint n) public    {
      bool r17 = updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r17(p,n);
      if(r17==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address p,uint amount) public    {
      bool r4 = updateMintOnInsertRecv_mint_r4(p,amount);
      if(r4==false) {
        revert("Rule condition failed");
      }
  }
  function unpause() public    {
      bool r5 = updateUnpauseOnInsertRecv_unpause_r5();
      if(r5==false) {
        revert("Rule condition failed");
      }
  }
  function renouncePauser() public    {
      bool r3 = updateRenouncePauserOnInsertRecv_renouncePauser_r3();
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function decreaseAllowance(address p,uint n) public    {
      bool r14 = updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r14(p,n);
      if(r14==false) {
        revert("Rule condition failed");
      }
  }
  function updatePausedOnInsertConstructor_r28() private    {
      paused = PausedTuple(false,true);
  }
  function updateRenouncePauserOnInsertRecv_renouncePauser_r3() private   returns (bool) {
      address s = msg.sender;
      if(true==isPauser[s].b) {
        updateIsPauserOnInsertRenouncePauser_r34(s,bool(false));
        emit RenouncePauser(s,false);
        return true;
      }
      return false;
  }
  function updateTotalInOnInsertTransfer_r11(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r29(p,delta0);
      totalIn[p].n += n;
  }
  function updateBalanceOfOnInsertTotalBurn_r29(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r29(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r8(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementDecreaseAllowanceTotal_r32(o,s,delta1);
      decreaseAllowanceTotal[o][s].m += n;
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r17(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      updateAllowanceTotalOnInsertIncreaseAllowance_r37(o,s,n);
      emit IncreaseAllowance(o,s,n);
      return true;
      return false;
  }
  function updateAddPauserOnInsertRecv_addPauser_r25(address p) private   returns (bool) {
      address s = msg.sender;
      if(true==isPauser[s].b) {
        updateIsPauserOnInsertAddPauser_r24(p,bool(true));
        emit AddPauser(p,true);
        return true;
      }
      return false;
  }
  function updateAllowanceOnDeleteAllowanceTotal_r32(address o,address s,uint m) private    {
      uint d = decreaseAllowanceTotal[o][s].m;
      uint l = spentTotal[o][s].m;
      uint n = (m-l)-d;
  }
  function updateUnpauseOnInsertRecv_unpause_r5() private   returns (bool) {
      if(true==paused.b) {
        address s = msg.sender;
        if(true==isPauser[s].b) {
          updatePausedOnInsertUnpause_r10(bool(false));
          emit Unpause(false);
          return true;
        }
      }
      return false;
  }
  function updatePausedOnInsertUnpause_r10(bool b) private    {
      paused = PausedTuple(b,true);
  }
  function updateSpentTotalOnInsertTransferFrom_r30(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r32(o,s,delta0);
      spentTotal[o][s].m += n;
  }
  function updateIsPauserOnInsertConstructor_r7() private    {
      address s = msg.sender;
      isPauser[s] = IsPauserTuple(true,true);
  }
  function updateBalanceOfOnIncrementTotalBurn_r29(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r29(p,newValue);
  }
  function updateAllowanceOnInsertSpentTotal_r32(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r32(o,s,toDelete.m);
      }
      uint d = decreaseAllowanceTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      uint n = (m-l)-d;
  }
  function totalSupply() private view  returns (uint) {
      uint b = allBurn.n;
      uint m = allMint.n;
      uint n = m-b;
      return n;
  }
  function updateBalanceOfOnInsertTotalMint_r29(address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r29(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateAllowanceOnIncrementSpentTotal_r32(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r32(o,s,newValue);
  }
  function updateAllowanceOnInsertDecreaseAllowanceTotal_r32(address o,address s,uint d) private    {
      DecreaseAllowanceTotalTuple memory toDelete = decreaseAllowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteDecreaseAllowanceTotal_r32(o,s,toDelete.m);
      }
      uint l = spentTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      uint n = (m-l)-d;
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r37(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r32(o,s,delta1);
      allowanceTotal[o][s].m += n;
  }
  function updateAllMintOnInsertConstructor_r16(uint n) private    {
      updateTotalSupplyOnInsertAllMint_r21(n);
      allMint = AllMintTuple(n,true);
  }
  function updatePausedOnInsertPause_r1(bool b) private    {
      paused = PausedTuple(b,true);
  }
  function updateBalanceOfOnDeleteTotalIn_r29(address p,uint i) private    {
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateTotalOutOnInsertTransfer_r26(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r29(p,delta0);
      totalOut[p].n += n;
  }
  function updateMintOnInsertRecv_mint_r4(address p,uint n) private   returns (bool) {
      if(false==paused.b) {
        address s = owner.p;
        if(s==msg.sender) {
          if(p!=address(0)) {
            updateTotalMintOnInsertMint_r19(p,n);
            updateAllMintOnInsertMint_r13(n);
            emit Mint(p,n);
            return true;
          }
        }
      }
      return false;
  }
  function updateAllBurnOnInsertBurn_r33(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r21(delta1);
      allBurn.n += n;
  }
  function updateTotalMintOnInsertMint_r19(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalMint_r29(p,delta2);
      totalMint[p].n += n;
  }
  function updateTotalBurnOnInsertBurn_r18(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r29(p,delta2);
      totalBurn[p].n += n;
  }
  function allowance(address o,address s) private view  returns (uint) {
      uint d = decreaseAllowanceTotal[o][s].m;
      uint l = spentTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      uint n = (m-l)-d;
      return n;
  }
  function updateBurnOnInsertRecv_burn_r12(address p,uint n) private   returns (bool) {
      address s = msg.sender;
      if(false==paused.b) {
        if(s==owner.p) {
          uint m = balanceOf(p);
          if(p!=address(0) && n<=m) {
            updateAllBurnOnInsertBurn_r33(n);
            updateTotalBurnOnInsertBurn_r18(p,n);
            emit Burn(p,n);
            return true;
          }
        }
      }
      return false;
  }
  function updateIsPauserOnInsertAddPauser_r24(address p,bool b) private    {
      isPauser[p] = IsPauserTuple(b,true);
  }
  function balanceOf(address p) private view  returns (uint) {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
      return s;
  }
  function updateBalanceOfOnInsertTotalIn_r29(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r29(p,toDelete.n);
      }
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateTotalSupplyOnInsertConstructor_r31(uint n) private    {
      // Empty()
  }
  function updateIsPauserOnInsertRenouncePauser_r34(address p,bool b) private    {
      isPauser[p] = IsPauserTuple(b,true);
  }
  function updateTotalMintOnInsertConstructor_r23(uint n) private    {
      address s = msg.sender;
      updateBalanceOfOnInsertTotalMint_r29(s,n);
      totalMint[s] = TotalMintTuple(n,true);
  }
  function updateBalanceOfOnInsertTotalOut_r29(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r29(p,toDelete.n);
      }
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalSupplyOnInsertAllMint_r21(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
  }
  function updateAllowanceOnInsertAllowanceTotal_r32(address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r32(o,s,toDelete.m);
      }
      uint d = decreaseAllowanceTotal[o][s].m;
      uint l = spentTotal[o][s].m;
      uint n = (m-l)-d;
  }
  function updateOwnerOnInsertConstructor_r9() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r14(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance(o,s);
      if(m>=n) {
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r8(o,s,n);
        emit DecreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
  function updateAllowanceOnIncrementDecreaseAllowanceTotal_r32(address o,address s,int d) private    {
      int _delta = int(d);
      uint newValue = updateuintByint(decreaseAllowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertDecreaseAllowanceTotal_r32(o,s,newValue);
  }
  function updateBalanceOfOnIncrementTotalOut_r29(address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r29(p,newValue);
  }
  function updateTransferOnInsertRecv_transfer_r15(address r,uint n) private   returns (bool) {
      if(false==paused.b) {
        address s = msg.sender;
        uint m = balanceOf(s);
        if(n<=m) {
          updateTotalInOnInsertTransfer_r11(r,n);
          updateTotalOutOnInsertTransfer_r26(s,n);
          emit Transfer(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r21(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r21(newValue);
  }
  function updateBalanceOfOnIncrementTotalIn_r29(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r29(p,newValue);
  }
  function updateBalanceOfOnInsertConstructor_r6(uint n) private    {
      address s = msg.sender;
      // Empty()
  }
  function updateBalanceOfOnDeleteTotalOut_r29(address p,uint o) private    {
      uint i = totalIn[p].n;
      uint m = totalBurn[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateBalanceOfOnDeleteTotalBurn_r29(address p,uint m) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint n = totalMint[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r35(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance(o,s);
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r37(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateTotalSupplyOnInsertAllBurn_r21(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
  }
  function updateTotalSupplyOnIncrementAllMint_r21(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r21(newValue);
  }
  function updateAllowanceOnDeleteDecreaseAllowanceTotal_r32(address o,address s,uint d) private    {
      uint l = spentTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      uint n = (m-l)-d;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r2(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(false==paused.b) {
        uint m = balanceOf(o);
        uint k = allowance(o,s);
        if(m>=n && k>=n) {
          updateSpentTotalOnInsertTransferFrom_r30(o,s,n);
          updateTransferOnInsertTransferFrom_r0(o,r,n);
          return true;
        }
      }
      return false;
  }
  function updateAllMintOnInsertMint_r13(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllMint_r21(delta1);
      allMint.n += n;
  }
  function updateBalanceOfOnDeleteTotalMint_r29(address p,uint n) private    {
      uint i = totalIn[p].n;
      uint o = totalOut[p].n;
      uint m = totalBurn[p].n;
      uint s = ((n+i)-m)-o;
  }
  function updateBalanceOfOnIncrementTotalMint_r29(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r29(p,newValue);
  }
  function updateAllowanceOnDeleteSpentTotal_r32(address o,address s,uint l) private    {
      uint d = decreaseAllowanceTotal[o][s].m;
      uint m = allowanceTotal[o][s].m;
      uint n = (m-l)-d;
  }
  function updateAllowanceOnIncrementAllowanceTotal_r32(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r32(o,s,newValue);
  }
  function updatePauseOnInsertRecv_pause_r20() private   returns (bool) {
      if(false==paused.b) {
        address s = msg.sender;
        if(true==isPauser[s].b) {
          updatePausedOnInsertPause_r1(bool(true));
          emit Pause(true);
          return true;
        }
      }
      return false;
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r26(o,n);
      updateTotalInOnInsertTransfer_r11(r,n);
      emit Transfer(o,r,n);
  }
  function updateTotalBalancesOnInsertConstructor_r36(uint n) private    {
      // Empty()
  }
}