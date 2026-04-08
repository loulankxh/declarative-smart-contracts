contract CryptoPunks {
  struct BidValueTuple {
    uint n;
    bool _valid;
  }
  struct AllPunksAssignedTuple {
    bool b;
    bool _valid;
  }
  struct TotalPendingDebitTuple {
    uint n;
    bool _valid;
  }
  struct PunkHasBidTuple {
    bool b;
    bool _valid;
  }
  struct OfferSellerTuple {
    address seller;
    bool _valid;
  }
  struct OfferMinValueTuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct PunkIndexToAddressTuple {
    address o;
    bool _valid;
  }
  struct PendingWithdrawalsTuple {
    uint n;
    bool _valid;
  }
  struct TotalPendingCreditTuple {
    uint n;
    bool _valid;
  }
  struct PunksOfferedForSaleTuple {
    bool b;
    bool _valid;
  }
  struct BuyPunkActionTuple {
    address buyer;
    address seller;
    uint punkIndex;
    uint paid;
    bool _valid;
  }
  struct BidBidderTuple {
    address bidder;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  mapping(uint=>BidValueTuple) bidValue;
  mapping(address=>TotalPendingCreditTuple) totalPendingCredit;
  AllPunksAssignedTuple allPunksAssigned;
  mapping(uint=>PunksOfferedForSaleTuple) punksOfferedForSale;
  mapping(address=>TotalPendingDebitTuple) totalPendingDebit;
  BuyPunkActionTuple buyPunkAction;
  mapping(uint=>PunkHasBidTuple) punkHasBid;
  mapping(uint=>OfferSellerTuple) offerSeller;
  mapping(uint=>OfferMinValueTuple) offerMinValue;
  OwnerTuple owner;
  mapping(uint=>PunkIndexToAddressTuple) punkIndexToAddress;
  mapping(address=>PendingWithdrawalsTuple) pendingWithdrawals;
  mapping(uint=>BidBidderTuple) bidBidder;
  mapping(address=>BalanceOfTuple) balanceOf;
  event TransferPunkAction(address from,address to,uint punkIndex);
  event EnterBidAction(uint punkIndex,address bidder,uint paid);
  event WithdrawAction(address p,uint amount);
  event WithdrawBidAction(address bidder,uint punkIndex,uint paid);
  event AllInitialOwnersAssignedAction();
  event GetPunkAction(address to,uint punkIndex);
  event PunkNoLongerForSaleAction(address seller,uint punkIndex);
  event OfferPunkForSaleAction(address seller,uint punkIndex,uint minSalePriceInWei);
  event PendingCredit(address p,uint n);
  constructor() public {
    updateOwnerOnInsertConstructor_r5();
    updateAllPunksAssignedOnInsertConstructor_r66();
  }
  function acceptBidForPunk(uint punkIndex,uint minPrice) public    {
      bool r57 = updateAcceptBidActionOnInsertRecv_acceptBidForPunk_r57(punkIndex,minPrice);
      if(r57==false) {
        revert("Rule condition failed");
      }
  }
  function transferPunk(address to,uint punkIndex) public    {
      bool r10 = updateTransferPunkActionOnInsertRecv_transferPunk_r10(to,punkIndex);
      if(r10==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function buyPunk(uint punkIndex) public  payable  {
      bool r60 = updateBuyPunkActionOnInsertRecv_buyPunk_r60(punkIndex);
      if(r60==false) {
        revert("Rule condition failed");
      }
  }
  function getBidBidder(uint punkIndex) public view  returns (address) {
      address bidder = bidBidder[punkIndex].bidder;
      return bidder;
  }
  function withdrawBidForPunk(uint punkIndex) public    {
      bool r51 = updateWithdrawBidActionOnInsertRecv_withdrawBidForPunk_r51(punkIndex);
      if(r51==false) {
        revert("Rule condition failed");
      }
  }
  function withdraw() public    {
      bool r33 = updateWithdrawActionOnInsertRecv_withdraw_r33();
      if(r33==false) {
        revert("Rule condition failed");
      }
  }
  function punkNoLongerForSale(uint punkIndex) public    {
      bool r86 = updatePunkNoLongerForSaleActionOnInsertRecv_punkNoLongerForSale_r86(punkIndex);
      if(r86==false) {
        revert("Rule condition failed");
      }
  }
  function getOfferMinValue(uint punkIndex) public view  returns (uint) {
      uint n = offerMinValue[punkIndex].n;
      return n;
  }
  function getPunk(uint punkIndex) public    {
      bool r55 = updateGetPunkActionOnInsertRecv_getPunk_r55(punkIndex);
      if(r55==false) {
        revert("Rule condition failed");
      }
  }
  function getPunksOfferedForSale(uint punkIndex) public view  returns (bool) {
      bool b = punksOfferedForSale[punkIndex].b;
      return b;
  }
  function getPunkHasBid(uint punkIndex) public view  returns (bool) {
      bool b = punkHasBid[punkIndex].b;
      return b;
  }
  function getPendingWithdrawals(address p) public view  returns (uint) {
      uint n = pendingWithdrawals[p].n;
      return n;
  }
  function getPunkIndexToAddress(uint punkIndex) public view  returns (address) {
      address o = punkIndexToAddress[punkIndex].o;
      return o;
  }
  function enterBidForPunk(uint punkIndex) public  payable  {
      bool r85 = updatePendingCreditOnInsertRecv_enterBidForPunk_r85(punkIndex);
      bool r14 = updateEnterBidActionOnInsertRecv_enterBidForPunk_r14(punkIndex);
      bool r71 = updateEnterBidActionOnInsertRecv_enterBidForPunk_r71(punkIndex);
      if(r85==false && r14==false && r71==false) {
        revert("Rule condition failed");
      }
  }
  function offerPunkForSale(uint punkIndex,uint minSalePriceInWei) public    {
      bool r36 = updateOfferPunkForSaleActionOnInsertRecv_offerPunkForSale_r36(punkIndex,minSalePriceInWei);
      if(r36==false) {
        revert("Rule condition failed");
      }
  }
  function getBidValue(uint punkIndex) public view  returns (uint) {
      uint n = bidValue[punkIndex].n;
      return n;
  }
  function getAllPunksAssigned() public view  returns (bool) {
      bool b = allPunksAssigned.b;
      return b;
  }
  function allInitialOwnersAssigned() public    {
      bool r42 = updateAllInitialOwnersAssignedActionOnInsertRecv_allInitialOwnersAssigned_r42();
      if(r42==false) {
        revert("Rule condition failed");
      }
  }
  function updatePunkIndexToAddressOnInsertAcceptBidAction_r12(address to,uint punkIndex) private    {
      punkIndexToAddress[punkIndex] = PunkIndexToAddressTuple(to,true);
  }
  function updateAcceptBidActionOnInsertRecv_acceptBidForPunk_r57(uint punkIndex,uint minPrice) private   returns (bool) {
      if(true==allPunksAssigned.b) {
        address seller = msg.sender;
        uint paid = bidValue[punkIndex].n;
        address bidder = bidBidder[punkIndex].bidder;
        if(true==punkHasBid[punkIndex].b) {
          if(seller==punkIndexToAddress[punkIndex].o) {
            if(seller!=address(0) && bidder!=address(0) && punkIndex<10000 && paid>=minPrice) {
              updateOfferMinValueOnInsertAcceptBidAction_r74(punkIndex);
              updateTouchedOfferOnInsertAcceptBidAction_r21(punkIndex);
              updateTotalAcceptedOutOnInsertAcceptBidAction_r17(seller,bidder,punkIndex,paid);
              updatePendingCreditOnInsertAcceptBidAction_r34(seller,paid);
              updatePunkHasBidOnInsertAcceptBidAction_r8(punkIndex);
              updateInitialBalanceOnInsertAcceptBidAction_r30(seller);
              updateTotalAcceptedInOnInsertAcceptBidAction_r75(seller,bidder,punkIndex,paid);
              updateTouchedBidOnInsertAcceptBidAction_r76(punkIndex);
              updateInitialBalanceOnInsertAcceptBidAction_r70(bidder);
              updatePunksOfferedForSaleOnInsertAcceptBidAction_r67(punkIndex);
              updateOfferSellerOnInsertAcceptBidAction_r27(punkIndex);
              updatePunkIndexToAddressOnInsertAcceptBidAction_r12(bidder,punkIndex);
              updateBidBidderOnInsertAcceptBidAction_r89(punkIndex);
              updateBidValueOnInsertAcceptBidAction_r4(punkIndex);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateTotalAcceptedInOnInsertAcceptBidAction_r75(address _seller0,address p,uint _punkIndex2,uint _paid3) private    {
      int delta0 = int(1);
      updateBalanceOfOnIncrementTotalAcceptedIn_r16(p,delta0);
  }
  function updateOfferMinValueOnInsertAcceptBidAction_r74(uint punkIndex) private    {
      offerMinValue[punkIndex] = OfferMinValueTuple(0,true);
  }
  function updateBidValueOnInsertBuyPunkAction_r82(uint punkIndex) private    {
      updatePendingCreditOnInsertBidValue_r38(punkIndex,uint(0));
      bidValue[punkIndex] = BidValueTuple(0,true);
  }
  function updateInitialBalanceOnInsertBuyPunkAction_r11(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r25(p,uint(0));
  }
  function updatePendingCreditOnInsertBidBidder_r38(uint punkIndex,address prevBidder) private    {
      uint existing = bidValue[punkIndex].n;
      if(true==punkHasBid[punkIndex].b) {
        if(punkIndex==buyPunkAction.punkIndex) {
          updateTotalPendingCreditOnInsertPendingCredit_r83(prevBidder,existing);
          updateInitialPendingOnInsertPendingCredit_r53(prevBidder);
          emit PendingCredit(prevBidder,existing);
        }
      }
  }
  function updateOfferSellerOnInsertBuyPunkAction_r46(uint punkIndex) private    {
      offerSeller[punkIndex] = OfferSellerTuple(address(0),true);
  }
  function updateTotalTransferInOnInsertTransferPunkAction_r18(address _from0,address p,uint _punkIndex2) private    {
      int delta0 = int(1);
      updateBalanceOfOnIncrementTotalTransferIn_r16(p,delta0);
  }
  function updateTotalAcceptedOutOnInsertAcceptBidAction_r17(address p,address _bidder1,uint _punkIndex2,uint _paid3) private    {
      int delta0 = int(1);
      updateBalanceOfOnIncrementTotalAcceptedOut_r16(p,delta0);
  }
  function updateBuyPunkActionOnInsertRecv_buyPunk_r60(uint punkIndex) private   returns (bool) {
      uint paid = msg.value;
      address buyer = msg.sender;
      if(true==allPunksAssigned.b) {
        address seller = offerSeller[punkIndex].seller;
        uint minValue = offerMinValue[punkIndex].n;
        if(seller==punkIndexToAddress[punkIndex].o) {
          if(true==punksOfferedForSale[punkIndex].b) {
            if(buyer!=address(0) && punkIndex<10000 && paid>=minValue) {
              updateInitialBalanceOnInsertBuyPunkAction_r81(buyer);
              updateOfferMinValueOnInsertBuyPunkAction_r61(punkIndex);
              updatePunksOfferedForSaleOnInsertBuyPunkAction_r88(punkIndex);
              updateTotalSoldOutOnInsertBuyPunkAction_r44(buyer,seller,punkIndex,paid);
              updateBidValueOnInsertBuyPunkAction_r82(punkIndex);
              updateTouchedOfferOnInsertBuyPunkAction_r43(punkIndex);
              updateTotalBoughtInOnInsertBuyPunkAction_r31(buyer,seller,punkIndex,paid);
              updatePunkHasBidOnInsertBuyPunkAction_r69(punkIndex);
              updatePunkIndexToAddressOnInsertBuyPunkAction_r39(buyer,punkIndex);
              updateInitialBalanceOnInsertBuyPunkAction_r11(seller);
              updatePendingCreditOnInsertBuyPunkAction_r63(seller,paid);
              updateBidBidderOnInsertBuyPunkAction_r40(punkIndex);
              updatePendingCreditOnInsertBuyPunkAction_r38(punkIndex);
              updateOfferSellerOnInsertBuyPunkAction_r46(punkIndex);
              updateTouchedBidOnInsertBuyPunkAction_r79(punkIndex);
              buyPunkAction = BuyPunkActionTuple(buyer,seller,punkIndex,paid,true);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updatePendingWithdrawalsOnIncrementTotalPendingDebit_r26(address p,int d) private    {
      int _delta = int(-d);
      uint newValue = updateuintByint(pendingWithdrawals[p].n,_delta);
      pendingWithdrawals[p].n = newValue;
  }
  function updateInitialPendingOnInsertPendingDebit_r0(address p) private    {
      updatePendingWithdrawalsOnInsertInitialPending_r26(p,uint(0));
  }
  function updateEnterBidActionOnInsertRecv_enterBidForPunk_r71(uint punkIndex) private   returns (bool) {
      address bidder = msg.sender;
      uint paid = msg.value;
      if(true==allPunksAssigned.b) {
        address ownerOfPunk = punkIndexToAddress[punkIndex].o;
        if(false==punkHasBid[punkIndex].b) {
          if(bidder!=address(0) && punkIndex<10000 && ownerOfPunk!=bidder && paid>0) {
            updateTouchedBidOnInsertEnterBidAction_r68(punkIndex);
            updateBidValueOnInsertEnterBidAction_r29(punkIndex,paid);
            updatePunkHasBidOnInsertEnterBidAction_r32(punkIndex);
            updateBidBidderOnInsertEnterBidAction_r23(punkIndex,bidder);
            emit EnterBidAction(punkIndex,bidder,paid);
            return true;
          }
        }
      }
      return false;
  }
  function updateInitialBalanceOnInsertBuyPunkAction_r81(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r25(p,uint(0));
  }
  function updateOfferMinValueOnInsertBuyPunkAction_r61(uint punkIndex) private    {
      offerMinValue[punkIndex] = OfferMinValueTuple(0,true);
  }
  function updatePunkHasBidOnInsertTouchedBid_r78(uint punkIndex) private    {
      updatePendingCreditOnInsertPunkHasBid_r38(punkIndex,bool(false));
      punkHasBid[punkIndex] = PunkHasBidTuple(false,true);
  }
  function updateBidValueOnInsertWithdrawBidAction_r45(uint punkIndex) private    {
      updatePendingCreditOnInsertBidValue_r38(punkIndex,uint(0));
      bidValue[punkIndex] = BidValueTuple(0,true);
  }
  function updateWithdrawBidActionOnInsertRecv_withdrawBidForPunk_r51(uint punkIndex) private   returns (bool) {
      address bidder = msg.sender;
      if(true==allPunksAssigned.b) {
        uint paid = bidValue[punkIndex].n;
        if(bidder==bidBidder[punkIndex].bidder) {
          if(true==punkHasBid[punkIndex].b) {
            if(bidder!=address(0) && punkIndex<10000) {
              updateTouchedBidOnInsertWithdrawBidAction_r19(punkIndex);
              updateBidBidderOnInsertWithdrawBidAction_r2(punkIndex);
              updatePunkHasBidOnInsertWithdrawBidAction_r35(punkIndex);
              updateBidValueOnInsertWithdrawBidAction_r45(punkIndex);
              updateSendOnInsertWithdrawBidAction_r15(bidder,paid);
              emit WithdrawBidAction(bidder,punkIndex,paid);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateTouchedOfferOnInsertPunkNoLongerForSaleAction_r77(uint punkIndex) private    {
      updateOfferMinValueOnInsertTouchedOffer_r58(punkIndex);
      updateOfferSellerOnInsertTouchedOffer_r62(punkIndex);
      updatePunksOfferedForSaleOnInsertTouchedOffer_r54(punkIndex);
  }
  function updateTouchedBidOnInsertEnterBidAction_r68(uint punkIndex) private    {
      updateBidBidderOnInsertTouchedBid_r1(punkIndex);
      updatePunkHasBidOnInsertTouchedBid_r78(punkIndex);
      updateBidValueOnInsertTouchedBid_r22(punkIndex);
  }
  function updateTouchedOfferOnInsertAcceptBidAction_r21(uint punkIndex) private    {
      updateOfferMinValueOnInsertTouchedOffer_r58(punkIndex);
      updateOfferSellerOnInsertTouchedOffer_r62(punkIndex);
      updatePunksOfferedForSaleOnInsertTouchedOffer_r54(punkIndex);
  }
  function updateTransferPunkActionOnInsertRecv_transferPunk_r10(address to,uint punkIndex) private   returns (bool) {
      if(true==allPunksAssigned.b) {
        address from = msg.sender;
        if(from==punkIndexToAddress[punkIndex].o) {
          if(from!=address(0) && to!=address(0) && punkIndex<10000) {
            updateTotalTransferInOnInsertTransferPunkAction_r18(from,to,punkIndex);
            updatePunkIndexToAddressOnInsertTransferPunkAction_r24(to,punkIndex);
            updateOfferSellerOnInsertTransferPunkAction_r13(punkIndex);
            updateTouchedOfferOnInsertTransferPunkAction_r50(punkIndex);
            updateOfferMinValueOnInsertTransferPunkAction_r56(punkIndex);
            updatePunksOfferedForSaleOnInsertTransferPunkAction_r9(punkIndex);
            updateInitialBalanceOnInsertTransferPunkAction_r3(to);
            updateInitialBalanceOnInsertTransferPunkAction_r20(from);
            updateTotalTransferOutOnInsertTransferPunkAction_r84(from,to,punkIndex);
            emit TransferPunkAction(from,to,punkIndex);
            return true;
          }
        }
      }
      return false;
  }
  function updateEnterBidActionOnInsertRecv_enterBidForPunk_r14(uint punkIndex) private   returns (bool) {
      address bidder = msg.sender;
      uint paid = msg.value;
      if(true==allPunksAssigned.b) {
        uint existing = bidValue[punkIndex].n;
        address ownerOfPunk = punkIndexToAddress[punkIndex].o;
        if(true==punkHasBid[punkIndex].b) {
          if(bidder!=address(0) && punkIndex<10000 && ownerOfPunk!=bidder && paid>existing) {
            updateTouchedBidOnInsertEnterBidAction_r68(punkIndex);
            updateBidValueOnInsertEnterBidAction_r29(punkIndex,paid);
            updatePunkHasBidOnInsertEnterBidAction_r32(punkIndex);
            updateBidBidderOnInsertEnterBidAction_r23(punkIndex,bidder);
            emit EnterBidAction(punkIndex,bidder,paid);
            return true;
          }
        }
      }
      return false;
  }
  function updateOfferSellerOnInsertPunkNoLongerForSaleAction_r47(uint punkIndex) private    {
      offerSeller[punkIndex] = OfferSellerTuple(address(0),true);
  }
  function updatePendingCreditOnInsertBidValue_r38(uint punkIndex,uint existing) private    {
      address prevBidder = bidBidder[punkIndex].bidder;
      if(true==punkHasBid[punkIndex].b) {
        if(punkIndex==buyPunkAction.punkIndex) {
          updateTotalPendingCreditOnInsertPendingCredit_r83(prevBidder,existing);
          updateInitialPendingOnInsertPendingCredit_r53(prevBidder);
          emit PendingCredit(prevBidder,existing);
        }
      }
  }
  function updateTouchedBidOnInsertBuyPunkAction_r79(uint punkIndex) private    {
      updateBidBidderOnInsertTouchedBid_r1(punkIndex);
      updatePunkHasBidOnInsertTouchedBid_r78(punkIndex);
      updateBidValueOnInsertTouchedBid_r22(punkIndex);
  }
  function updateBalanceOfOnIncrementTotalAcceptedIn_r16(address p,int ai) private    {
      int _delta = int(ai);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateBalanceOfOnIncrementTotalTransferIn_r16(address p,int ti) private    {
      int _delta = int(ti);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateBidBidderOnInsertTouchedBid_r1(uint punkIndex) private    {
      updatePendingCreditOnInsertBidBidder_r38(punkIndex,address(0));
      bidBidder[punkIndex] = BidBidderTuple(address(0),true);
  }
  function updateTotalBoughtInOnInsertBuyPunkAction_r31(address p,address _seller1,uint _punkIndex2,uint _paid3) private    {
      int delta0 = int(1);
      updateBalanceOfOnIncrementTotalBoughtIn_r16(p,delta0);
  }
  function updateInitialBalanceOnInsertTransferPunkAction_r20(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r25(p,uint(0));
  }
  function updatePendingWithdrawalsOnIncrementTotalPendingCredit_r26(address p,int c) private    {
      int _delta = int(c);
      uint newValue = updateuintByint(pendingWithdrawals[p].n,_delta);
      pendingWithdrawals[p].n = newValue;
  }
  function updatePunkIndexToAddressOnInsertTransferPunkAction_r24(address to,uint punkIndex) private    {
      punkIndexToAddress[punkIndex] = PunkIndexToAddressTuple(to,true);
  }
  function updateSendOnInsertWithdrawBidAction_r15(address p,uint amount) private    {
      payable(p).send(amount);
  }
  function updateOfferMinValueOnInsertTransferPunkAction_r56(uint punkIndex) private    {
      offerMinValue[punkIndex] = OfferMinValueTuple(0,true);
  }
  function updateBalanceOfOnIncrementTotalSoldOut_r16(address p,int so) private    {
      int _delta = int(-so);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTouchedBidOnInsertAcceptBidAction_r76(uint punkIndex) private    {
      updateBidBidderOnInsertTouchedBid_r1(punkIndex);
      updatePunkHasBidOnInsertTouchedBid_r78(punkIndex);
      updateBidValueOnInsertTouchedBid_r22(punkIndex);
  }
  function updatePunkHasBidOnInsertAcceptBidAction_r8(uint punkIndex) private    {
      updatePendingCreditOnInsertPunkHasBid_r38(punkIndex,bool(false));
      punkHasBid[punkIndex] = PunkHasBidTuple(false,true);
  }
  function updateGetPunkActionOnInsertRecv_getPunk_r55(uint punkIndex) private   returns (bool) {
      if(true==allPunksAssigned.b) {
        address s = msg.sender;
        if(s!=address(0) && punkIndex<10000) {
          updateTotalClaimedOnInsertGetPunkAction_r65(s,punkIndex);
          updateTouchedOfferOnInsertGetPunkAction_r87(punkIndex);
          updatePunkIndexToAddressOnInsertGetPunkAction_r49(s,punkIndex);
          updateTouchedBidOnInsertGetPunkAction_r52(punkIndex);
          updateInitialBalanceOnInsertGetPunkAction_r80(s);
          emit GetPunkAction(s,punkIndex);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalBoughtIn_r16(address p,int bi) private    {
      int _delta = int(bi);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTouchedBidOnInsertWithdrawBidAction_r19(uint punkIndex) private    {
      updateBidBidderOnInsertTouchedBid_r1(punkIndex);
      updatePunkHasBidOnInsertTouchedBid_r78(punkIndex);
      updateBidValueOnInsertTouchedBid_r22(punkIndex);
  }
  function updateBidValueOnInsertTouchedBid_r22(uint punkIndex) private    {
      updatePendingCreditOnInsertBidValue_r38(punkIndex,uint(0));
      bidValue[punkIndex] = BidValueTuple(0,true);
  }
  function updateBidValueOnInsertEnterBidAction_r29(uint punkIndex,uint value) private    {
      updatePendingCreditOnInsertBidValue_r38(punkIndex,value);
      bidValue[punkIndex] = BidValueTuple(value,true);
  }
  function updateOwnerOnInsertConstructor_r5() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateBidBidderOnInsertBuyPunkAction_r40(uint punkIndex) private    {
      updatePendingCreditOnInsertBidBidder_r38(punkIndex,address(0));
      bidBidder[punkIndex] = BidBidderTuple(address(0),true);
  }
  function updatePendingWithdrawalsOnInsertInitialPending_r26(address p,uint i) private    {
      uint d = totalPendingDebit[p].n;
      uint c = totalPendingCredit[p].n;
      uint s = (i+c)-d;
      pendingWithdrawals[p] = PendingWithdrawalsTuple(s,true);
  }
  function updatePunkIndexToAddressOnInsertGetPunkAction_r49(address to,uint punkIndex) private    {
      punkIndexToAddress[punkIndex] = PunkIndexToAddressTuple(to,true);
  }
  function updateTotalTransferOutOnInsertTransferPunkAction_r84(address p,address _to1,uint _punkIndex2) private    {
      int delta0 = int(1);
      updateBalanceOfOnIncrementTotalTransferOut_r16(p,delta0);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateAllInitialOwnersAssignedActionOnInsertRecv_allInitialOwnersAssigned_r42() private   returns (bool) {
      if(false==allPunksAssigned.b) {
        address s = owner.p;
        if(s==msg.sender) {
          updateAllPunksAssignedOnInsertAllInitialOwnersAssignedAction_r7();
          emit AllInitialOwnersAssignedAction();
          return true;
        }
      }
      return false;
  }
  function updatePunkIndexToAddressOnInsertBuyPunkAction_r39(address to,uint punkIndex) private    {
      punkIndexToAddress[punkIndex] = PunkIndexToAddressTuple(to,true);
  }
  function updatePendingCreditOnInsertBuyPunkAction_r38(uint punkIndex) private    {
      uint existing = bidValue[punkIndex].n;
      address prevBidder = bidBidder[punkIndex].bidder;
      if(true==punkHasBid[punkIndex].b) {
        updateTotalPendingCreditOnInsertPendingCredit_r83(prevBidder,existing);
        updateInitialPendingOnInsertPendingCredit_r53(prevBidder);
        emit PendingCredit(prevBidder,existing);
      }
  }
  function updatePendingCreditOnInsertPunkHasBid_r38(uint punkIndex,bool true) private    {
      uint existing = bidValue[punkIndex].n;
      address prevBidder = bidBidder[punkIndex].bidder;
      if(punkIndex==buyPunkAction.punkIndex) {
        updateTotalPendingCreditOnInsertPendingCredit_r83(prevBidder,existing);
        updateInitialPendingOnInsertPendingCredit_r53(prevBidder);
        emit PendingCredit(prevBidder,existing);
      }
  }
  function updateOfferPunkForSaleActionOnInsertRecv_offerPunkForSale_r36(uint punkIndex,uint minSalePriceInWei) private   returns (bool) {
      if(true==allPunksAssigned.b) {
        address seller = msg.sender;
        if(seller==punkIndexToAddress[punkIndex].o) {
          if(seller!=address(0) && punkIndex<10000) {
            updateTouchedOfferOnInsertOfferPunkForSaleAction_r6(punkIndex);
            updateOfferMinValueOnInsertOfferPunkForSaleAction_r37(punkIndex,minSalePriceInWei);
            updateOfferSellerOnInsertOfferPunkForSaleAction_r48(seller,punkIndex);
            updatePunksOfferedForSaleOnInsertOfferPunkForSaleAction_r73(punkIndex);
            emit OfferPunkForSaleAction(seller,punkIndex,minSalePriceInWei);
            return true;
          }
        }
      }
      return false;
  }
  function updateBidBidderOnInsertWithdrawBidAction_r2(uint punkIndex) private    {
      updatePendingCreditOnInsertBidBidder_r38(punkIndex,address(0));
      bidBidder[punkIndex] = BidBidderTuple(address(0),true);
  }
  function updateTouchedOfferOnInsertTransferPunkAction_r50(uint punkIndex) private    {
      updateOfferMinValueOnInsertTouchedOffer_r58(punkIndex);
      updateOfferSellerOnInsertTouchedOffer_r62(punkIndex);
      updatePunksOfferedForSaleOnInsertTouchedOffer_r54(punkIndex);
  }
  function updatePendingCreditOnInsertRecv_enterBidForPunk_r85(uint punkIndex) private   returns (bool) {
      uint paid = msg.value;
      if(true==allPunksAssigned.b) {
        uint existing = bidValue[punkIndex].n;
        if(true==punkHasBid[punkIndex].b) {
          address prevBidder = bidBidder[punkIndex].bidder;
          if(paid>existing) {
            updateTotalPendingCreditOnInsertPendingCredit_r83(prevBidder,existing);
            updateInitialPendingOnInsertPendingCredit_r53(prevBidder);
            emit PendingCredit(prevBidder,existing);
            return true;
          }
        }
      }
      return false;
  }
  function updateOfferSellerOnInsertTouchedOffer_r62(uint punkIndex) private    {
      offerSeller[punkIndex] = OfferSellerTuple(address(0),true);
  }
  function updatePunkHasBidOnInsertEnterBidAction_r32(uint punkIndex) private    {
      updatePendingCreditOnInsertPunkHasBid_r38(punkIndex,bool(true));
      punkHasBid[punkIndex] = PunkHasBidTuple(true,true);
  }
  function updateOfferMinValueOnInsertTouchedOffer_r58(uint punkIndex) private    {
      offerMinValue[punkIndex] = OfferMinValueTuple(0,true);
  }
  function updatePunksOfferedForSaleOnInsertTouchedOffer_r54(uint punkIndex) private    {
      punksOfferedForSale[punkIndex] = PunksOfferedForSaleTuple(false,true);
  }
  function updatePendingCreditOnInsertBuyPunkAction_r63(address seller,uint paid) private    {
      updateTotalPendingCreditOnInsertPendingCredit_r83(seller,paid);
      updateInitialPendingOnInsertPendingCredit_r53(seller);
      emit PendingCredit(seller,paid);
  }
  function updateTotalSoldOutOnInsertBuyPunkAction_r44(address _buyer0,address p,uint _punkIndex2,uint _paid3) private    {
      int delta0 = int(1);
      updateBalanceOfOnIncrementTotalSoldOut_r16(p,delta0);
  }
  function updateWithdrawActionOnInsertRecv_withdraw_r33() private   returns (bool) {
      if(true==allPunksAssigned.b) {
        address p = msg.sender;
        uint amount = pendingWithdrawals[p].n;
        if(p!=address(0) && amount>0) {
          updateSendOnInsertWithdrawAction_r41(p,amount);
          updatePendingDebitOnInsertWithdrawAction_r28(p,amount);
          emit WithdrawAction(p,amount);
          return true;
        }
      }
      return false;
  }
  function updatePendingDebitOnInsertWithdrawAction_r28(address p,uint amount) private    {
      updateTotalPendingDebitOnInsertPendingDebit_r64(p,amount);
      updateInitialPendingOnInsertPendingDebit_r0(p);
  }
  function updatePunksOfferedForSaleOnInsertOfferPunkForSaleAction_r73(uint punkIndex) private    {
      punksOfferedForSale[punkIndex] = PunksOfferedForSaleTuple(true,true);
  }
  function updateSendOnInsertWithdrawAction_r41(address p,uint amount) private    {
      payable(p).send(amount);
  }
  function updateTotalClaimedOnInsertGetPunkAction_r65(address p,uint _punkIndex1) private    {
      int delta0 = int(1);
      updateBalanceOfOnIncrementTotalClaimed_r16(p,delta0);
  }
  function updateInitialBalanceOnInsertAcceptBidAction_r70(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r25(p,uint(0));
  }
  function updateTouchedOfferOnInsertBuyPunkAction_r43(uint punkIndex) private    {
      updateOfferMinValueOnInsertTouchedOffer_r58(punkIndex);
      updateOfferSellerOnInsertTouchedOffer_r62(punkIndex);
      updatePunksOfferedForSaleOnInsertTouchedOffer_r54(punkIndex);
  }
  function updatePunkNoLongerForSaleActionOnInsertRecv_punkNoLongerForSale_r86(uint punkIndex) private   returns (bool) {
      if(true==allPunksAssigned.b) {
        address seller = msg.sender;
        if(seller==punkIndexToAddress[punkIndex].o) {
          if(seller!=address(0) && punkIndex<10000) {
            updateTouchedOfferOnInsertPunkNoLongerForSaleAction_r77(punkIndex);
            updateOfferSellerOnInsertPunkNoLongerForSaleAction_r47(punkIndex);
            updatePunksOfferedForSaleOnInsertPunkNoLongerForSaleAction_r59(punkIndex);
            updateOfferMinValueOnInsertPunkNoLongerForSaleAction_r72(punkIndex);
            emit PunkNoLongerForSaleAction(seller,punkIndex);
            return true;
          }
        }
      }
      return false;
  }
  function updateBidBidderOnInsertEnterBidAction_r23(uint punkIndex,address bidder) private    {
      updatePendingCreditOnInsertBidBidder_r38(punkIndex,bidder);
      bidBidder[punkIndex] = BidBidderTuple(bidder,true);
  }
  function updateOfferMinValueOnInsertPunkNoLongerForSaleAction_r72(uint punkIndex) private    {
      offerMinValue[punkIndex] = OfferMinValueTuple(0,true);
  }
  function updatePunksOfferedForSaleOnInsertPunkNoLongerForSaleAction_r59(uint punkIndex) private    {
      punksOfferedForSale[punkIndex] = PunksOfferedForSaleTuple(false,true);
  }
  function updateAllPunksAssignedOnInsertAllInitialOwnersAssignedAction_r7() private    {
      allPunksAssigned = AllPunksAssignedTuple(true,true);
  }
  function updateTouchedOfferOnInsertGetPunkAction_r87(uint punkIndex) private    {
      updateOfferMinValueOnInsertTouchedOffer_r58(punkIndex);
      updateOfferSellerOnInsertTouchedOffer_r62(punkIndex);
      updatePunksOfferedForSaleOnInsertTouchedOffer_r54(punkIndex);
  }
  function updateInitialBalanceOnInsertTransferPunkAction_r3(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r25(p,uint(0));
  }
  function updateTouchedOfferOnInsertOfferPunkForSaleAction_r6(uint punkIndex) private    {
      updateOfferMinValueOnInsertTouchedOffer_r58(punkIndex);
      updateOfferSellerOnInsertTouchedOffer_r62(punkIndex);
      updatePunksOfferedForSaleOnInsertTouchedOffer_r54(punkIndex);
  }
  function updatePunksOfferedForSaleOnInsertAcceptBidAction_r67(uint punkIndex) private    {
      punksOfferedForSale[punkIndex] = PunksOfferedForSaleTuple(false,true);
  }
  function updateTouchedBidOnInsertGetPunkAction_r52(uint punkIndex) private    {
      updateBidBidderOnInsertTouchedBid_r1(punkIndex);
      updatePunkHasBidOnInsertTouchedBid_r78(punkIndex);
      updateBidValueOnInsertTouchedBid_r22(punkIndex);
  }
  function updateOfferSellerOnInsertOfferPunkForSaleAction_r48(address seller,uint punkIndex) private    {
      offerSeller[punkIndex] = OfferSellerTuple(seller,true);
  }
  function updateBalanceOfOnIncrementTotalClaimed_r16(address p,int c) private    {
      int _delta = int(c);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateInitialPendingOnInsertPendingCredit_r53(address p) private    {
      updatePendingWithdrawalsOnInsertInitialPending_r26(p,uint(0));
  }
  function updateOfferMinValueOnInsertOfferPunkForSaleAction_r37(uint punkIndex,uint minValue) private    {
      offerMinValue[punkIndex] = OfferMinValueTuple(minValue,true);
  }
  function updateBidValueOnInsertAcceptBidAction_r4(uint punkIndex) private    {
      updatePendingCreditOnInsertBidValue_r38(punkIndex,uint(0));
      bidValue[punkIndex] = BidValueTuple(0,true);
  }
  function updateBidBidderOnInsertAcceptBidAction_r89(uint punkIndex) private    {
      updatePendingCreditOnInsertBidBidder_r38(punkIndex,address(0));
      bidBidder[punkIndex] = BidBidderTuple(address(0),true);
  }
  function updateBalanceOfOnIncrementTotalTransferOut_r16(address p,int to) private    {
      int _delta = int(-to);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updatePunkHasBidOnInsertBuyPunkAction_r69(uint punkIndex) private    {
      updatePendingCreditOnInsertPunkHasBid_r38(punkIndex,bool(false));
      punkHasBid[punkIndex] = PunkHasBidTuple(false,true);
  }
  function updatePendingCreditOnInsertAcceptBidAction_r34(address seller,uint paid) private    {
      updateTotalPendingCreditOnInsertPendingCredit_r83(seller,paid);
      updateInitialPendingOnInsertPendingCredit_r53(seller);
      emit PendingCredit(seller,paid);
  }
  function updatePunksOfferedForSaleOnInsertBuyPunkAction_r88(uint punkIndex) private    {
      punksOfferedForSale[punkIndex] = PunksOfferedForSaleTuple(false,true);
  }
  function updateOfferSellerOnInsertTransferPunkAction_r13(uint punkIndex) private    {
      offerSeller[punkIndex] = OfferSellerTuple(address(0),true);
  }
  function updateAllPunksAssignedOnInsertConstructor_r66() private    {
      allPunksAssigned = AllPunksAssignedTuple(false,true);
  }
  function updateBalanceOfOnIncrementTotalInitial_r16(address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalPendingCreditOnInsertPendingCredit_r83(address p,uint n) private    {
      int delta0 = int(n);
      updatePendingWithdrawalsOnIncrementTotalPendingCredit_r26(p,delta0);
      totalPendingCredit[p].n += n;
  }
  function updateTotalInitialOnInsertInitialBalance_r25(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInitial_r16(p,delta0);
  }
  function updateInitialBalanceOnInsertAcceptBidAction_r30(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r25(p,uint(0));
  }
  function updateBalanceOfOnIncrementTotalAcceptedOut_r16(address p,int ao) private    {
      int _delta = int(-ao);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateInitialBalanceOnInsertGetPunkAction_r80(address p) private    {
      updateTotalInitialOnInsertInitialBalance_r25(p,uint(0));
  }
  function updateOfferSellerOnInsertAcceptBidAction_r27(uint punkIndex) private    {
      offerSeller[punkIndex] = OfferSellerTuple(address(0),true);
  }
  function updatePunksOfferedForSaleOnInsertTransferPunkAction_r9(uint punkIndex) private    {
      punksOfferedForSale[punkIndex] = PunksOfferedForSaleTuple(false,true);
  }
  function updatePunkHasBidOnInsertWithdrawBidAction_r35(uint punkIndex) private    {
      updatePendingCreditOnInsertPunkHasBid_r38(punkIndex,bool(false));
      punkHasBid[punkIndex] = PunkHasBidTuple(false,true);
  }
  function updateTotalPendingDebitOnInsertPendingDebit_r64(address p,uint n) private    {
      int delta0 = int(n);
      updatePendingWithdrawalsOnIncrementTotalPendingDebit_r26(p,delta0);
      totalPendingDebit[p].n += n;
  }
}