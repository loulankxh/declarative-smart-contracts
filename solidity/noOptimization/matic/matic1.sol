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
  struct TotalSupplyTuple {
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
  TotalSupplyTuple totalSupply;
  AllMintTuple allMint;
  mapping(address=>IsPauserTuple) isPauser;
  mapping(address=>mapping(address=>AllowanceTotalTuple)) allowanceTotal;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
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
    updatePausedOnInsertConstructor_r28();
    updateAllMintOnInsertConstructor_r16(n);
    updateTotalMintOnInsertConstructor_r23(n);
    updateIsPauserOnInsertConstructor_r7();
    updateOwnerOnInsertConstructor_r9();
    updateBalanceOfOnInsertConstructor_r6(n);
    updateTotalBalancesOnInsertConstructor_r36(n);
    updateTotalSupplyOnInsertConstructor_r31(n);
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
  function approve(address s,uint n) public    {
      bool r35 = updateIncreaseAllowanceOnInsertRecv_approve_r35(s,n);
      if(r35==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint n = balanceOfTuple.n;
      return n;
  }
  function pause() public    {
      bool r20 = updatePauseOnInsertRecv_pause_r20();
      if(r20==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r2 = updateTransferFromOnInsertRecv_transferFrom_r2(from,to,amount);
      if(r2==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      AllowanceTuple memory allowanceTuple = allowance[p][s];
      uint n = allowanceTuple.n;
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
  function updateTotalInOnInsertTransfer_r11(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r29(p,delta0);
      totalIn[p].n += n;
  }
  function updateTotalMintOnInsertConstructor_r23(uint n) private    {
      address s = msg.sender;
      updateBalanceOfOnInsertTotalMint_r29(s,n);
      totalMint[s] = TotalMintTuple(n,true);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r2(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(false==paused.b) {
        BalanceOfTuple memory balanceOfTuple = balanceOf[o];
        uint m = balanceOfTuple.n;
        AllowanceTuple memory allowanceTuple = allowance[s][o];
        uint k = allowanceTuple.n;
        if(m>=n && k>=n) {
          updateSpentTotalOnInsertTransferFrom_r30(o,s,n);
          updateTransferOnInsertTransferFrom_r0(o,r,n);
          return true;
        }
      }
      return false;
  }
  function updateAllowanceOnInsertSpentTotal_r32(address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r32(o,s,toDelete.m);
      }
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o];
      uint m = allowanceTotalTuple.m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateBalanceOfOnDeleteTotalOut_r29(address p,uint o) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updatePausedOnInsertUnpause_r10(bool b) private    {
      paused = PausedTuple(b,true);
  }
  function updateAllowanceOnDeleteDecreaseAllowanceTotal_r32(address o,address s,uint d) private    {
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o];
      uint m = allowanceTotalTuple.m;
      uint n = (m-l)-d;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateSpentTotalOnInsertTransferFrom_r30(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r32(o,s,delta0);
      spentTotal[o][s].m += n;
  }
  function updateOwnerOnInsertConstructor_r9() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateBalanceOfOnIncrementTotalBurn_r29(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r29(p,newValue);
  }
  function updateAllowanceOnIncrementSpentTotal_r32(address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r32(o,s,newValue);
  }
  function updateAddPauserOnInsertRecv_addPauser_r25(address p) private   returns (bool) {
      address s = msg.sender;
      IsPauserTuple memory isPauserTuple = isPauser[s];
      if(true==isPauserTuple.b) {
        updateIsPauserOnInsertAddPauser_r24(p,bool(true));
        emit AddPauser(p,true);
        return true;
      }
      return false;
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
  function updateAllowanceOnDeleteAllowanceTotal_r32(address o,address s,uint m) private    {
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      uint n = (m-l)-d;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updatePausedOnInsertPause_r1(bool b) private    {
      paused = PausedTuple(b,true);
  }
  function updateTotalOutOnInsertTransfer_r26(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r29(p,delta0);
      totalOut[p].n += n;
  }
  function updateBalanceOfOnDeleteTotalIn_r29(address p,uint i) private    {
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateAllBurnOnInsertBurn_r33(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r21(delta1);
      allBurn.n += n;
  }
  function updatePauseOnInsertRecv_pause_r20() private   returns (bool) {
      if(false==paused.b) {
        address s = msg.sender;
        IsPauserTuple memory isPauserTuple = isPauser[s];
        if(true==isPauserTuple.b) {
          updatePausedOnInsertPause_r1(bool(true));
          emit Pause(true);
          return true;
        }
      }
      return false;
  }
  function updateTotalBurnOnInsertBurn_r18(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r29(p,delta2);
      totalBurn[p].n += n;
  }
  function updateIsPauserOnInsertAddPauser_r24(address p,bool b) private    {
      isPauser[p] = IsPauserTuple(b,true);
  }
  function updateBalanceOfOnDeleteTotalBurn_r29(address p,uint m) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalSupplyOnInsertAllMint_r21(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r14(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint m = allowanceTuple.n;
      if(m>=n) {
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r8(o,s,n);
        emit DecreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r17(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      updateAllowanceTotalOnInsertIncreaseAllowance_r37(o,s,n);
      emit IncreaseAllowance(o,s,n);
      return true;
      return false;
  }
  function updateTotalSupplyOnInsertConstructor_r31(uint n) private    {
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateIsPauserOnInsertRenouncePauser_r34(address p,bool b) private    {
      isPauser[p] = IsPauserTuple(b,true);
  }
  function updateTotalSupplyOnInsertAllBurn_r21(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
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
  function updateRenouncePauserOnInsertRecv_renouncePauser_r3() private   returns (bool) {
      address s = msg.sender;
      IsPauserTuple memory isPauserTuple = isPauser[s];
      if(true==isPauserTuple.b) {
        updateIsPauserOnInsertRenouncePauser_r34(s,bool(false));
        emit RenouncePauser(s,false);
        return true;
      }
      return false;
  }
  function updateAllowanceOnInsertDecreaseAllowanceTotal_r32(address o,address s,uint d) private    {
      DecreaseAllowanceTotalTuple memory toDelete = decreaseAllowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteDecreaseAllowanceTotal_r32(o,s,toDelete.m);
      }
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o];
      uint m = allowanceTotalTuple.m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateAllowanceOnDeleteSpentTotal_r32(address o,address s,uint l) private    {
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o];
      uint m = allowanceTotalTuple.m;
      uint n = (m-l)-d;
      AllowanceTuple memory allowanceTuple = allowance[o][s];
      if(n==allowanceTuple.n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateBalanceOfOnInsertTotalOut_r29(address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r29(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateUnpauseOnInsertRecv_unpause_r5() private   returns (bool) {
      if(true==paused.b) {
        address s = msg.sender;
        IsPauserTuple memory isPauserTuple = isPauser[s];
        if(true==isPauserTuple.b) {
          updatePausedOnInsertUnpause_r10(bool(false));
          emit Unpause(false);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnInsertTotalIn_r29(address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r29(p,toDelete.n);
      }
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalSupplyOnIncrementAllMint_r21(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r21(newValue);
  }
  function updateBalanceOfOnDeleteTotalMint_r29(address p,uint n) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateAllMintOnInsertMint_r13(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllMint_r21(delta1);
      allMint.n += n;
  }
  function updateBalanceOfOnInsertConstructor_r6(uint n) private    {
      address s = msg.sender;
      balanceOf[s] = BalanceOfTuple(n,true);
  }
  function updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r8(address o,address s,uint n) private    {
      int delta1 = int(n);
      updateAllowanceOnIncrementDecreaseAllowanceTotal_r32(o,s,delta1);
      decreaseAllowanceTotal[o][s].m += n;
  }
  function updateAllowanceOnInsertAllowanceTotal_r32(address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r32(o,s,toDelete.m);
      }
      DecreaseAllowanceTotalTuple memory decreaseAllowanceTotalTuple = decreaseAllowanceTotal[s][o];
      uint d = decreaseAllowanceTotalTuple.m;
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o];
      uint l = spentTotalTuple.m;
      uint n = (m-l)-d;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateTransferOnInsertRecv_transfer_r15(address r,uint n) private   returns (bool) {
      if(false==paused.b) {
        address s = msg.sender;
        BalanceOfTuple memory balanceOfTuple = balanceOf[s];
        uint m = balanceOfTuple.n;
        if(n<=m) {
          updateTotalInOnInsertTransfer_r11(r,n);
          updateTotalOutOnInsertTransfer_r26(s,n);
          emit Transfer(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r35(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o];
      uint m = allowanceTuple.n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r37(o,s,d);
      emit IncreaseAllowance(o,s,d);
      return true;
      return false;
  }
  function updateBalanceOfOnInsertTotalMint_r29(address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r29(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p];
      uint m = totalBurnTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnIncrementTotalMint_r29(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r29(p,newValue);
  }
  function updateBurnOnInsertRecv_burn_r12(address p,uint n) private   returns (bool) {
      address s = msg.sender;
      if(false==paused.b) {
        if(s==owner.p) {
          BalanceOfTuple memory balanceOfTuple = balanceOf[p];
          uint m = balanceOfTuple.n;
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
  function updateAllowanceOnIncrementAllowanceTotal_r32(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r32(o,s,newValue);
  }
  function updateTransferOnInsertTransferFrom_r0(address o,address r,uint n) private    {
      updateTotalOutOnInsertTransfer_r26(o,n);
      updateTotalInOnInsertTransfer_r11(r,n);
      emit Transfer(o,r,n);
  }
  function updateBalanceOfOnInsertTotalBurn_r29(address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r29(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalMintOnInsertMint_r19(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMint_r29(p,delta0);
      totalMint[p].n += n;
  }
  function updateIsPauserOnInsertConstructor_r7() private    {
      address s = msg.sender;
      isPauser[s] = IsPauserTuple(true,true);
  }
  function updateTotalBalancesOnInsertConstructor_r36(uint n) private    {
      // Empty()
  }
}