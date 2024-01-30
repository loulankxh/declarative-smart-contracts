contract Auction {
  struct BalanceTuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct BeneficiaryTuple {
    address p;
    bool _valid;
  }
  struct WithdrawTotalTuple {
    uint n;
    bool _valid;
  }
  struct HighestBidTuple {
    address bidder;
    uint amount;
    bool _valid;
  }
  struct EndTimeTuple {
    uint t;
    bool _valid;
  }
  struct EndTuple {
    bool b;
    bool _valid;
  }
  struct BidTotalTuple {
    uint n;
    bool _valid;
  }
  mapping(address=>BalanceTuple) balance;
  OwnerTuple owner;
  BeneficiaryTuple beneficiary;
  mapping(address=>WithdrawTotalTuple) withdrawTotal;
  HighestBidTuple highestBid;
  EndTimeTuple endTime;
  mapping(address=>BidTotalTuple) bidTotal;
  EndTuple end;
  event EndAuction(bool b);
  event Send(address p,uint amount);
  event Bid(address bidder,uint amount);
  constructor(address beneficiary,uint biddingTime) public {
    updateOwnerOnInsertConstructor_r9();
    updateEndTimeOnInsertConstructor_r15(biddingTime);
    updateBeneficiaryOnInsertConstructor_r11(beneficiary);
  }
  function bid() public  payable  {
      bool r10 = updateBidOnInsertRecv_bid_r10();
      if(r10==false) {
        revert("Rule condition failed");
      }
  }
  function withdraw() public    {
      bool r2 = updateWithdrawOnInsertRecv_withdraw_r2();
      bool r5 = updateWithdrawOnInsertRecv_withdraw_r5();
      if(r2==false && r5==false) {
        revert("Rule condition failed");
      }
  }
  function endAuction() public    {
      bool r13 = updateEndAuctionOnInsertRecv_endAuction_r13();
      bool r3 = updateSendOnInsertRecv_endAuction_r3();
      if(r13==false && r3==false) {
        revert("Rule condition failed");
      }
  }
  function getBalance(address p) public view  returns (uint) {
      BalanceTuple memory balanceTuple = balance[p];
      uint n = balanceTuple.n;
      return n;
  }
  function updateBalanceOnInsertBidTotal_r7(address p,uint b) private    {
      BidTotalTuple memory toDelete = bidTotal[p];
      if(toDelete._valid==true) {
        updateBalanceOnDeleteBidTotal_r7(p,toDelete.n);
      }
      WithdrawTotalTuple memory withdrawTotalTuple = withdrawTotal[p];
      uint w = withdrawTotalTuple.n;
      uint n = b-w;
      balance[p] = BalanceTuple(n,true);
  }
  function updateOwnerOnInsertConstructor_r9() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateEndAuctionOnInsertRecv_endAuction_r13() private   returns (bool) {
      uint t1 = block.timestamp;
      address s = msg.sender;
      uint t2 = endTime.t;
      if(false==end.b) {
        if(s==owner.p) {
          if(t1>=t2) {
            updateEndOnInsertEndAuction_r0(bool(true));
            emit EndAuction(true);
            return true;
          }
        }
      }
      return false;
  }
  function updateBidTotalOnInsertBid_r12(address p,uint m) private    {
      int delta2 = int(m);
      updateBalanceOnIncrementBidTotal_r7(p,delta2);
      bidTotal[p].n += m;
  }
  function updateWithdrawOnInsertRecv_withdraw_r2() private   returns (bool) {
      address p = highestBid.bidder;
      uint m = highestBid.amount;
      if(true==end.b) {
        if(p==msg.sender) {
          BalanceTuple memory balanceTuple = balance[p];
          uint n = balanceTuple.n;
          if(n>m) {
            uint s = n-m;
            updateWithdrawTotalOnInsertWithdraw_r4(p,s);
            updateSendOnInsertWithdraw_r8(p,s);
            return true;
          }
        }
      }
      return false;
  }
  function updateWithdrawTotalOnInsertWithdraw_r4(address p,uint m) private    {
      int delta1 = int(m);
      updateBalanceOnIncrementWithdrawTotal_r7(p,delta1);
      withdrawTotal[p].n += m;
  }
  function updateSendOnInsertRecv_endAuction_r3() private   returns (bool) {
      uint t1 = block.timestamp;
      address s = msg.sender;
      address p = beneficiary.p;
      uint t2 = endTime.t;
      uint n = highestBid.amount;
      if(false==end.b) {
        if(s==owner.p) {
          if(t1>=t2) {
            payable(p).send(n);
            emit Send(p,n);
            return true;
          }
        }
      }
      return false;
  }
  function updateBalanceOnIncrementBidTotal_r7(address p,int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(bidTotal[p].n,_delta);
      updateBalanceOnInsertBidTotal_r7(p,newValue);
  }
  function updateEndTimeOnInsertConstructor_r15(uint d) private    {
      uint t = block.timestamp;
      uint t2 = t+d;
      endTime = EndTimeTuple(t2,true);
  }
  function updateBeneficiaryOnInsertConstructor_r11(address p) private    {
      beneficiary = BeneficiaryTuple(p,true);
  }
  function updateHighestBidOnInsertBid_r1(address p,uint m) private    {
      HighestBidTuple memory highestBidTuple = highestBid;
      uint _max = highestBid.amount;
      if(m>_max) {
        highestBid = HighestBidTuple(p,m,true);
      }
  }
  function updateEndOnInsertEndAuction_r0(bool p) private    {
      if(p==true) {
        end = EndTuple(true,true);
      }
  }
  function updateWithdrawOnInsertRecv_withdraw_r5() private   returns (bool) {
      if(true==end.b) {
        address h = highestBid.bidder;
        address p = msg.sender;
        BalanceTuple memory balanceTuple = balance[p];
        uint n = balanceTuple.n;
        if(p!=h && n>0) {
          updateWithdrawTotalOnInsertWithdraw_r4(p,n);
          updateSendOnInsertWithdraw_r8(p,n);
          return true;
        }
      }
      return false;
  }
  function updateBidOnInsertRecv_bid_r10() private   returns (bool) {
      uint t1 = block.timestamp;
      uint t2 = endTime.t;
      uint m = highestBid.amount;
      if(false==end.b) {
        uint n = msg.value;
        address p = msg.sender;
        if(n>m && t1<t2) {
          updateHighestBidOnInsertBid_r1(p,n);
          updateBidTotalOnInsertBid_r12(p,n);
          emit Bid(p,n);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOnDeleteBidTotal_r7(address p,uint b) private    {
      WithdrawTotalTuple memory withdrawTotalTuple = withdrawTotal[p];
      uint w = withdrawTotalTuple.n;
      uint n = b-w;
      BalanceTuple memory balanceTuple = balance[p];
      if(n==balanceTuple.n) {
        balance[p] = BalanceTuple(0,false);
      }
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBalanceOnIncrementWithdrawTotal_r7(address p,int w) private    {
      int _delta = int(w);
      uint newValue = updateuintByint(withdrawTotal[p].n,_delta);
      updateBalanceOnInsertWithdrawTotal_r7(p,newValue);
  }
  function updateBalanceOnInsertWithdrawTotal_r7(address p,uint w) private    {
      WithdrawTotalTuple memory toDelete = withdrawTotal[p];
      if(toDelete._valid==true) {
        updateBalanceOnDeleteWithdrawTotal_r7(p,toDelete.n);
      }
      BidTotalTuple memory bidTotalTuple = bidTotal[p];
      uint b = bidTotalTuple.n;
      uint n = b-w;
      balance[p] = BalanceTuple(n,true);
  }
  function updateSendOnInsertWithdraw_r8(address p,uint n) private    {
      payable(p).send(n);
      emit Send(p,n);
  }
  function updateBalanceOnDeleteWithdrawTotal_r7(address p,uint w) private    {
      BidTotalTuple memory bidTotalTuple = bidTotal[p];
      uint b = bidTotalTuple.n;
      uint n = b-w;
      BalanceTuple memory balanceTuple = balance[p];
      if(n==balanceTuple.n) {
        balance[p] = BalanceTuple(0,false);
      }
  }
}