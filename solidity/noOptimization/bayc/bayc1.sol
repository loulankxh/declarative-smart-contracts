contract Bayc {
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct SaleIsActiveTuple {
    bool b;
    bool _valid;
  }
  struct TotalMintedByTuple {
    uint n;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct REVEAL_TIMESTAMPTuple {
    uint t;
    bool _valid;
  }
  struct InitialBalanceTuple {
    address p;
    uint n;
    bool _valid;
  }
  struct TotalMintedTuple {
    uint n;
    bool _valid;
  }
  struct InitialSupplyTuple {
    uint n;
    bool _valid;
  }
  struct TotalReservedTuple {
    uint n;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct MAX_APESTuple {
    uint n;
    bool _valid;
  }
  struct TotalInitialTuple {
    uint n;
    bool _valid;
  }
  struct TotalReserveTuple {
    uint n;
    bool _valid;
  }
  OwnerTuple owner;
  SaleIsActiveTuple saleIsActive;
  mapping(address=>TotalInitialTuple) totalInitial;
  mapping(address=>TotalMintedByTuple) totalMintedBy;
  mapping(address=>TotalSupplyTuple) totalSupply;
  REVEAL_TIMESTAMPTuple REVEAL_TIMESTAMP;
  InitialBalanceTuple initialBalance;
  TotalMintedTuple totalMinted;
  TotalReserveTuple totalReserve;
  InitialSupplyTuple initialSupply;
  mapping(address=>BalanceOfTuple) balanceOf;
  MAX_APESTuple MAX_APES;
  mapping(address=>TotalReservedTuple) totalReserved;
  event FlipSaleStateAction(bool newState);
  event ReserveApesAction(address to,uint minted);
  event MintApeAction(address to,uint minted);
  event SetRevealTimestampAction(uint revealTimeStamp);
  constructor(uint maxNftSupply,uint saleStart) public {
    updateSaleIsActiveOnInsertConstructor_r9();
    updateMAX_APESOnInsertConstructor_r3(maxNftSupply);
    updateOwnerOnInsertConstructor_r5();
    updateInitialSupplyOnInsertConstructor_r1();
    updateREVEAL_TIMESTAMPOnInsertConstructor_r18(saleStart);
  }
  function getSaleIsActive() public view  returns (bool) {
      bool b = saleIsActive.b;
      return b;
  }
  function setRevealTimestamp(uint revealTimeStamp) public    {
      bool r12 = updateSetRevealTimestampActionOnInsertRecv_setRevealTimestamp_r12(revealTimeStamp);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function flipSaleState() public    {
      bool r16 = updateFlipSaleStateActionOnInsertRecv_flipSaleState_r16();
      bool r14 = updateFlipSaleStateActionOnInsertRecv_flipSaleState_r14();
      if(r16==false && r14==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function getREVEAL_TIMESTAMP() public view  returns (uint) {
      uint t = REVEAL_TIMESTAMP.t;
      return t;
  }
  function reserveApes() public    {
      bool r20 = updateReserveApesActionOnInsertRecv_reserveApes_r20();
      if(r20==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply(address ownerKey) public view  returns (uint) {
      uint n = totalSupply[ownerKey].n;
      return n;
  }
  function mintApe(uint numberOfTokens) public  payable  {
      bool r13 = updateMintApeActionOnInsertRecv_mintApe_r13(numberOfTokens);
      if(r13==false) {
        revert("Rule condition failed");
      }
  }
  function updateBalanceOfOnInsertTotalInitial_r0(address p,uint i) private    {
      TotalInitialTuple memory toDelete = totalInitial[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalInitial_r0(p,toDelete.n);
      }
      uint m = totalMintedBy[p].n;
      uint r = totalReserved[p].n;
      uint s = (i+r)+m;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateSetRevealTimestampActionOnInsertRecv_setRevealTimestamp_r12(uint t) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updateREVEAL_TIMESTAMPOnInsertSetRevealTimestampAction_r17(t);
        emit SetRevealTimestampAction(t);
        return true;
      }
      return false;
  }
  function updateREVEAL_TIMESTAMPOnInsertSetRevealTimestampAction_r17(uint t) private    {
      REVEAL_TIMESTAMP = REVEAL_TIMESTAMPTuple(t,true);
  }
  function updateBalanceOfOnDeleteTotalMintedBy_r0(address p,uint m) private    {
      uint r = totalReserved[p].n;
      uint i = totalInitial[p].n;
      uint s = (i+r)+m;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateReserveApesActionOnInsertRecv_reserveApes_r20() private   returns (bool) {
      uint m = MAX_APES.n;
      address s = msg.sender;
      if(s==owner.p) {
        uint ts = totalSupply[s].n;
        if(ts+30<=m) {
          updateTotalReserveOnInsertReserveApesAction_r15(uint(30));
          updateTotalReservedOnInsertReserveApesAction_r11(s,uint(30));
          updateInitialBalanceOnInsertReserveApesAction_r6(s);
          emit ReserveApesAction(s,30);
          return true;
        }
      }
      return false;
  }
  function updateTotalSupplyOnIncrementTotalReserve_r8(int r) private    {
      int _delta = int(r);
      uint newValue = updateuintByint(totalReserve.n,_delta);
      updateTotalSupplyOnInsertTotalReserve_r8(newValue);
  }
  function updateMAX_APESOnInsertConstructor_r3(uint n) private    {
      MAX_APES = MAX_APESTuple(n,true);
  }
  function updateFlipSaleStateActionOnInsertRecv_flipSaleState_r14() private   returns (bool) {
      if(true==saleIsActive.b) {
        address s = owner.p;
        if(s==msg.sender) {
          updateSaleIsActiveOnInsertFlipSaleStateAction_r10(bool(false));
          emit FlipSaleStateAction(false);
          return true;
        }
      }
      return false;
  }
  function updateTotalInitialOnInsertInitialBalance_r4(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalInitial_r0(p,delta2);
      totalInitial[p].n += n;
  }
  function updateBalanceOfOnIncrementTotalReserved_r0(address p,int r) private    {
      int _delta = int(r);
      uint newValue = updateuintByint(totalReserved[p].n,_delta);
      updateBalanceOfOnInsertTotalReserved_r0(p,newValue);
  }
  function updateTotalMintedByOnInsertMintApeAction_r19(address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalMintedBy_r0(p,delta2);
      totalMintedBy[p].n += n;
  }
  function updateTotalReservedOnInsertReserveApesAction_r11(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalReserved_r0(p,delta0);
      totalReserved[p].n += n;
  }
  function updateREVEAL_TIMESTAMPOnInsertConstructor_r18(uint saleStart) private    {
      uint t = saleStart+777600;
      REVEAL_TIMESTAMP = REVEAL_TIMESTAMPTuple(t,true);
  }
  function updateSaleIsActiveOnInsertConstructor_r9() private    {
      saleIsActive = SaleIsActiveTuple(false,true);
  }
  function updateBalanceOfOnDeleteTotalInitial_r0(address p,uint i) private    {
      uint m = totalMintedBy[p].n;
      uint r = totalReserved[p].n;
      uint s = (i+r)+m;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalSupplyOnInsertTotalReserve_r8(uint r) private    {
      address o = owner.p;
      uint m = totalMinted.n;
      uint i = initialSupply.n;
      uint s = (i+r)+m;
      totalSupply[o] = TotalSupplyTuple(s,true);
  }
  function updateInitialBalanceOnInsertReserveApesAction_r6(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r4(p,uint(0));
      initialBalance = InitialBalanceTuple(p,0,true);
  }
  function updateMintApeActionOnInsertRecv_mintApe_r13(uint n) private   returns (bool) {
      uint m = MAX_APES.n;
      address s = msg.sender;
      if(true==saleIsActive.b) {
        uint v = msg.value;
        address o = owner.p;
        uint ts = totalSupply[o].n;
        if(n>0 && n<=20 && ts+n<=m && v>=80000000000000000*n) {
          updateTotalMintedByOnInsertMintApeAction_r19(s,n);
          updateTotalMintedOnInsertMintApeAction_r2(n);
          updateInitialBalanceOnInsertMintApeAction_r7(s);
          emit MintApeAction(s,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalSupplyOnInsertTotalMinted_r8(uint m) private    {
      address o = owner.p;
      uint r = totalReserve.n;
      uint i = initialSupply.n;
      uint s = (i+r)+m;
      totalSupply[o] = TotalSupplyTuple(s,true);
  }
  function updateInitialSupplyOnInsertConstructor_r1() private    {
      initialSupply = InitialSupplyTuple(0,true);
  }
  function updateTotalMintedOnInsertMintApeAction_r2(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementTotalMinted_r8(delta0);
      totalMinted.n += n;
  }
  function updateBalanceOfOnIncrementTotalMintedBy_r0(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalMintedBy[p].n,_delta);
      updateBalanceOfOnInsertTotalMintedBy_r0(p,newValue);
  }
  function updateTotalReserveOnInsertReserveApesAction_r15(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementTotalReserve_r8(delta1);
      totalReserve.n += n;
  }
  function updateBalanceOfOnDeleteTotalReserved_r0(address p,uint r) private    {
      uint m = totalMintedBy[p].n;
      uint i = totalInitial[p].n;
      uint s = (i+r)+m;
      if(s==balanceOf[p].n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateFlipSaleStateActionOnInsertRecv_flipSaleState_r16() private   returns (bool) {
      if(false==saleIsActive.b) {
        address s = owner.p;
        if(s==msg.sender) {
          updateSaleIsActiveOnInsertFlipSaleStateAction_r10(bool(true));
          emit FlipSaleStateAction(true);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnInsertTotalReserved_r0(address p,uint r) private    {
      TotalReservedTuple memory toDelete = totalReserved[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalReserved_r0(p,toDelete.n);
      }
      uint m = totalMintedBy[p].n;
      uint i = totalInitial[p].n;
      uint s = (i+r)+m;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnIncrementTotalInitial_r0(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalInitial[p].n,_delta);
      updateBalanceOfOnInsertTotalInitial_r0(p,newValue);
  }
  function updateOwnerOnInsertConstructor_r5() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateBalanceOfOnInsertTotalMintedBy_r0(address p,uint m) private    {
      TotalMintedByTuple memory toDelete = totalMintedBy[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMintedBy_r0(p,toDelete.n);
      }
      uint r = totalReserved[p].n;
      uint i = totalInitial[p].n;
      uint s = (i+r)+m;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateTotalSupplyOnIncrementTotalMinted_r8(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalMinted.n,_delta);
      updateTotalSupplyOnInsertTotalMinted_r8(newValue);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateInitialBalanceOnInsertMintApeAction_r7(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r4(p,uint(0));
      initialBalance = InitialBalanceTuple(p,0,true);
  }
  function updateSaleIsActiveOnInsertFlipSaleStateAction_r10(bool b) private    {
      saleIsActive = SaleIsActiveTuple(b,true);
  }
}