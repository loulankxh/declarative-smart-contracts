contract Ppg {
  struct PRICETuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct InitialBalanceWeiTuple {
    uint n;
    bool _valid;
  }
  struct TotalMintTuple {
    uint n;
    bool _valid;
  }
  struct TotalWithdrawnTuple {
    uint n;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct MAX_ELEMENTSTuple {
    uint n;
    bool _valid;
  }
  struct CreatorAddressTuple {
    address p;
    bool _valid;
  }
  struct MAX_BY_MINTTuple {
    uint n;
    bool _valid;
  }
  struct DevAddressTuple {
    address p;
    bool _valid;
  }
  struct TotalReceivedTuple {
    uint n;
    bool _valid;
  }
  struct BaseURIMarkerTuple {
    uint n;
    bool _valid;
  }
  struct PausedTuple {
    bool b;
    bool _valid;
  }
  PRICETuple PRICE;
  OwnerTuple owner;
  mapping(address=>InitialBalanceWeiTuple) initialBalanceWei;
  CreatorAddressTuple creatorAddress;
  mapping(address=>TotalMintTuple) totalMint;
  mapping(address=>TotalReceivedTuple) totalReceived;
  mapping(address=>TotalWithdrawnTuple) totalWithdrawn;
  mapping(address=>BalanceOfTuple) balanceOf;
  MAX_ELEMENTSTuple MAX_ELEMENTS;
  MAX_BY_MINTTuple MAX_BY_MINT;
  DevAddressTuple devAddress;
  BaseURIMarkerTuple baseURIMarker;
  PausedTuple paused;
  event SetBaseURIAction(uint baseURI);
  event WithdrawDev(address to,uint amount);
  event WithdrawCreator(address to,uint amount);
  event PauseAction(bool val);
  event MintAction(address to,uint minted,uint paid);
  constructor(uint baseURI,address creator,address dev) public {
    updatePausedOnInsertConstructor_r17();
    updateOwnerOnInsertConstructor_r21();
    updateInitialMintOnInsertConstructor_r12();
    updateMAX_BY_MINTOnInsertConstructor_r22();
    updateMAX_ELEMENTSOnInsertConstructor_r6();
    updatePRICEOnInsertConstructor_r3();
    updateCreatorAddressOnInsertConstructor_r8(creator);
    updateBaseURIMarkerOnInsertConstructor_r27(baseURI);
    updateInitialBalanceWeiOnInsertConstructor_r28();
    updateDevAddressOnInsertConstructor_r5(dev);
  }
  function getPaused() public view  returns (bool) {
      bool b = paused.b;
      return b;
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function getContractBalance(address ownerKey) public view  returns (uint) {
      uint n = contractBalance(ownerKey);
      return n;
  }
  function getBaseURIMarker() public view  returns (uint) {
      uint n = baseURIMarker.n;
      return n;
  }
  function pause(bool val) public    {
      bool r4 = updatePauseActionOnInsertRecv_pause_r4(val);
      if(r4==false) {
        revert("Rule condition failed");
      }
  }
  function withdrawAll() public    {
      bool r7 = updateWithdrawDevOnInsertRecv_withdrawAll_r7();
      bool r1 = updateWithdrawCreatorOnInsertRecv_withdrawAll_r1();
      if(r7==false && r1==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalMint(address ownerKey) public view  returns (uint) {
      uint n = totalMint[ownerKey].n;
      return n;
  }
  function mint(address to,uint count) public  payable  {
      bool r15 = updateMintActionOnInsertRecv_mint_r15(to,count);
      bool r18 = updateMintActionOnInsertRecv_mint_r18(to,count);
      if(r15==false && r18==false) {
        revert("Rule condition failed");
      }
  }
  function setBaseURI(uint baseURI) public    {
      bool r9 = updateSetBaseURIActionOnInsertRecv_setBaseURI_r9(baseURI);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function updateTotalMintedOnInsertMintAction_r23(uint n) private    {
      int delta0 = int(n);
      updateTotalMintOnIncrementTotalMinted_r20(delta0);
  }
  function updatePRICEOnInsertConstructor_r3() private    {
      PRICE = PRICETuple(30000000000000000,true);
  }
  function updateMintActionOnInsertRecv_mint_r18(address to,uint n) private   returns (bool) {
      address s = msg.sender;
      uint p = PRICE.n;
      uint mm = MAX_BY_MINT.n;
      uint m = MAX_ELEMENTS.n;
      uint v = msg.value;
      if(s==owner.p) {
        uint ts = totalMint[s].n;
        if(ts+n<=m && ts<=m && n<=mm && v>=p*n) {
          updateTotalMintedByOnInsertMintAction_r26(to,n);
          updateInitialBalanceOnInsertMintAction_r2(to);
          updateTotalMintedOnInsertMintAction_r23(n);
          updateTotalReceivedOnInsertMintAction_r14(v);
          emit MintAction(to,n,v);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalMintedBy_r19(address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateBaseURIMarkerOnInsertSetBaseURIAction_r30(uint b) private    {
      baseURIMarker = BaseURIMarkerTuple(b,true);
  }
  function updateOwnerOnInsertConstructor_r21() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateSendOnInsertWithdrawCreator_r10(address p,uint n) private    {
      payable(p).send(n);
  }
  function updateCreatorAddressOnInsertConstructor_r8(address c) private    {
      creatorAddress = CreatorAddressTuple(c,true);
  }
  function updateTotalReceivedOnInsertMintAction_r14(uint v) private    {
      int delta0 = int(v);
      updateContractBalanceOnIncrementTotalReceived_r11(o,delta0);
      totalReceived[o].n += v;
  }
  function updateWithdrawCreatorOnInsertRecv_withdrawAll_r1() private   returns (bool) {
      address s = msg.sender;
      address c = creatorAddress.p;
      if(s==owner.p) {
        uint b = contractBalance(s);
        if(b>0) {
          uint d = (b*35)/100;
          uint n = b-d;
          updateTotalWithdrawnCreatorOnInsertWithdrawCreator_r24(n);
          updateSendOnInsertWithdrawCreator_r10(c,n);
          emit WithdrawCreator(c,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalWithdrawnDevOnInsertWithdrawDev_r25(uint n) private    {
      int delta0 = int(n);
      updateTotalWithdrawnOnIncrementTotalWithdrawnDev_r13(o,delta0);
  }
  function updateTotalMintOnIncrementTotalMinted_r20(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalMint[o].n,_delta);
      totalMint[o].n = newValue;
  }
  function updateSetBaseURIActionOnInsertRecv_setBaseURI_r9(uint b) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updateBaseURIMarkerOnInsertSetBaseURIAction_r30(b);
        emit SetBaseURIAction(b);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalInitial_r19(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateWithdrawDevOnInsertRecv_withdrawAll_r7() private   returns (bool) {
      address d = devAddress.p;
      address s = msg.sender;
      if(s==owner.p) {
        uint b = contractBalance(s);
        if(b>0) {
          uint n = (b*35)/100;
          updateTotalWithdrawnDevOnInsertWithdrawDev_r25(n);
          updateSendOnInsertWithdrawDev_r16(d,n);
          emit WithdrawDev(d,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalWithdrawnOnIncrementTotalWithdrawnCreator_r13(address o,int c) private    {
      int delta0 = int(c);
      updateContractBalanceOnIncrementTotalWithdrawn_r11(o,delta0);
      int _delta = int(c);
      uint newValue = updateuintByint(totalWithdrawn[o].n,_delta);
      totalWithdrawn[o].n = newValue;
  }
  function updateTotalWithdrawnCreatorOnInsertWithdrawCreator_r24(uint n) private    {
      int delta0 = int(n);
      updateTotalWithdrawnOnIncrementTotalWithdrawnCreator_r13(o,delta0);
  }
  function contractBalance(address o) private view  returns (uint) {
      uint w = totalWithdrawn[o].n;
      uint r = totalReceived[o].n;
      uint i = initialBalanceWei[o].n;
      uint b = (i+r)-w;
      return b;
  }
  function updateInitialBalanceWeiOnInsertConstructor_r28() private    {
      address o = owner.p;
      initialBalanceWei[o] = InitialBalanceWeiTuple(0,true);
  }
  function updateTotalMintedByOnInsertMintAction_r26(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMintedBy_r19(p,delta0);
  }
  function updateMAX_ELEMENTSOnInsertConstructor_r6() private    {
      MAX_ELEMENTS = MAX_ELEMENTSTuple(8888,true);
  }
  function updateMAX_BY_MINTOnInsertConstructor_r22() private    {
      MAX_BY_MINT = MAX_BY_MINTTuple(20,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalInitialOnInsertInitialBalance_r0(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInitial_r19(p,delta0);
  }
  function updateContractBalanceOnIncrementTotalWithdrawn_r11(address o,int w) private    {
      // Empty()
  }
  function updatePausedOnInsertConstructor_r17() private    {
      paused = PausedTuple(true,true);
  }
  function updateContractBalanceOnIncrementTotalReceived_r11(address o,int r) private    {
      // Empty()
  }
  function updateSendOnInsertWithdrawDev_r16(address p,uint n) private    {
      payable(p).send(n);
  }
  function updatePausedOnInsertPauseAction_r29(bool v) private    {
      paused = PausedTuple(v,true);
  }
  function updateDevAddressOnInsertConstructor_r5(address d) private    {
      devAddress = DevAddressTuple(d,true);
  }
  function updatePauseActionOnInsertRecv_pause_r4(bool v) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updatePausedOnInsertPauseAction_r29(v);
        emit PauseAction(v);
        return true;
      }
      return false;
  }
  function updateMintActionOnInsertRecv_mint_r15(address to,uint n) private   returns (bool) {
      if(false==paused.b) {
        uint mm = MAX_BY_MINT.n;
        address s = msg.sender;
        uint p = PRICE.n;
        uint m = MAX_ELEMENTS.n;
        uint v = msg.value;
        address o = owner.p;
        uint ts = totalMint[o].n;
        if(n<=mm && s!=o && ts<=m && ts+n<=m && v>=p*n) {
          updateTotalMintedByOnInsertMintAction_r26(to,n);
          updateInitialBalanceOnInsertMintAction_r2(to);
          updateTotalMintedOnInsertMintAction_r23(n);
          updateTotalReceivedOnInsertMintAction_r14(v);
          emit MintAction(to,n,v);
          return true;
        }
      }
      return false;
  }
  function updateInitialBalanceOnInsertMintAction_r2(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r0(p,uint(0));
  }
  function updateTotalWithdrawnOnIncrementTotalWithdrawnDev_r13(address o,int d) private    {
      int delta0 = int(d);
      updateContractBalanceOnIncrementTotalWithdrawn_r11(o,delta0);
      int _delta = int(d);
      uint newValue = updateuintByint(totalWithdrawn[o].n,_delta);
      totalWithdrawn[o].n = newValue;
  }
  function updateInitialMintOnInsertConstructor_r12() private    {
      // Empty()
  }
  function updateBaseURIMarkerOnInsertConstructor_r27(uint b) private    {
      baseURIMarker = BaseURIMarkerTuple(b,true);
  }
}