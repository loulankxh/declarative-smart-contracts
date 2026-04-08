contract Bayc {
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct SaleIsActiveTuple {
    bool b;
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
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct MAX_APESTuple {
    uint n;
    bool _valid;
  }
  OwnerTuple owner;
  SaleIsActiveTuple saleIsActive;
  mapping(address=>TotalSupplyTuple) totalSupply;
  REVEAL_TIMESTAMPTuple REVEAL_TIMESTAMP;
  mapping(address=>BalanceOfTuple) balanceOf;
  MAX_APESTuple MAX_APES;
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
  function updateBalanceOfOnIncrementTotalReserved_r0(address p,int r) private    {
      int _delta = int(r);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
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
  function updateTotalMintedByOnInsertMintApeAction_r19(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMintedBy_r0(p,delta0);
  }
  function updateTotalSupplyOnIncrementTotalReserve_r8(int r) private    {
      int _delta = int(r);
      uint newValue = updateuintByint(totalSupply[o].n,_delta);
      totalSupply[o].n = newValue;
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
  function updateBalanceOfOnIncrementTotalInitial_r0(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalSupplyOnIncrementTotalMinted_r8(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalSupply[o].n,_delta);
      totalSupply[o].n = newValue;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateSaleIsActiveOnInsertFlipSaleStateAction_r10(bool b) private    {
      saleIsActive = SaleIsActiveTuple(b,true);
  }
  function updateREVEAL_TIMESTAMPOnInsertConstructor_r18(uint saleStart) private    {
      uint t = saleStart+777600;
      REVEAL_TIMESTAMP = REVEAL_TIMESTAMPTuple(t,true);
  }
  function updateSaleIsActiveOnInsertConstructor_r9() private    {
      saleIsActive = SaleIsActiveTuple(false,true);
  }
  function updateTotalMintedOnInsertMintApeAction_r2(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementTotalMinted_r8(delta0);
  }
  function updateInitialSupplyOnInsertConstructor_r1() private    {
      // Empty()
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
  function updateTotalReservedOnInsertReserveApesAction_r11(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalReserved_r0(p,delta0);
  }
  function updateInitialBalanceOnInsertReserveApesAction_r6(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r4(p,uint(0));
  }
  function updateOwnerOnInsertConstructor_r5() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateBalanceOfOnIncrementTotalMintedBy_r0(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
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
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInitial_r0(p,delta0);
  }
  function updateTotalReserveOnInsertReserveApesAction_r15(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementTotalReserve_r8(delta0);
  }
  function updateInitialBalanceOnInsertMintApeAction_r7(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r4(p,uint(0));
  }
}