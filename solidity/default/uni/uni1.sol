contract Uni {
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct VotesTuple {
    uint n;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct DelegatesTuple {
    address d;
    bool _valid;
  }
  mapping(address=>VotesTuple) votes;
  TotalSupplyTuple totalSupply;
  mapping(address=>DelegatesTuple) delegates;
  mapping(address=>BalanceOfTuple) balanceOf;
  event DelegateSet(address delegator,address delegatee);
  event Transfer(address from,address to,uint amount);
  constructor(address holder,uint supply) public {
    updateInitialBalanceOnInsertConstructor_r19(holder,supply);
    updateTotalSupplyOnInsertConstructor_r20(supply);
  }
  function delegateBySig(address delegator,address delegatee) public    {
      bool r16 = updateDelegateSetOnInsertRecv_delegateBySig_r16(delegator,delegatee);
      if(r16==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address to,uint amount) public    {
      bool r10 = updateTransferOnInsertRecv_transfer_r10(to,amount);
      if(r10==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function delegate(address delegatee) public    {
      bool r3 = updateDelegateSetOnInsertRecv_delegate_r3(delegatee);
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function getVotes(address d) public view  returns (uint) {
      uint n = votes[d].n;
      return n;
  }
  function getDelegates(address p) public view  returns (address) {
      address d = delegates[p].d;
      return d;
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function updateVoteContributionOnIncrementBalanceOf_r13(address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      updateVoteContributionOnInsertBalanceOf_r13(p,newValue);
  }
  function updateBalanceOfOnIncrementTotalInitial_r14(address p,int i) private    {
      int delta0 = int(i);
      updateVoteContributionOnIncrementBalanceOf_r13(p,delta0);
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalSupplyOnInsertConstructor_r20(uint n) private    {
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateDelegateSetOnInsertRecv_delegate_r3(address d) private   returns (bool) {
      address p = msg.sender;
      if(p!=address(0) && d!=address(0)) {
        updateInitialBalanceOnInsertDelegateSet_r0(p);
        updateDelegatesOnInsertDelegateSet_r4(p,d);
        updateInitialBalanceOnInsertDelegateSet_r2(d);
        emit DelegateSet(p,d);
        return true;
      }
      return false;
  }
  function updateInValOnInsertInitialBalance_r15(address p) private    {
      updateTotalInOnInsertInVal_r18(p,uint(0));
  }
  function updateInitialBalanceOnInsertTransfer_r17(address p) private    {
      updateOutValOnInsertInitialBalance_r8(p);
      updateInValOnInsertInitialBalance_r15(p);
      updateTotalInitialOnInsertInitialBalance_r7(p,uint(0));
  }
  function updateTotalInOnInsertInVal_r18(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r14(p,delta0);
  }
  function updateInValOnInsertTransfer_r12(address p,uint n) private    {
      updateTotalInOnInsertInVal_r18(p,n);
  }
  function updateOutValOnInsertInitialBalance_r8(address p) private    {
      updateTotalOutOnInsertOutVal_r21(p,uint(0));
  }
  function updateBalanceOfOnIncrementTotalIn_r14(address p,int t) private    {
      int delta0 = int(t);
      updateVoteContributionOnIncrementBalanceOf_r13(p,delta0);
      int _delta = int(t);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalInitialOnInsertInitialBalance_r7(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInitial_r14(p,delta0);
  }
  function updateDelegatesOnInsertDelegateSet_r4(address p,address d) private    {
      updateVoteContributionOnInsertDelegates_r13(p,d);
      delegates[p] = DelegatesTuple(d,true);
  }
  function updateDelegateSetOnInsertRecv_delegateBySig_r16(address p,address d) private   returns (bool) {
      if(p!=address(0) && d!=address(0)) {
        updateInitialBalanceOnInsertDelegateSet_r0(p);
        updateDelegatesOnInsertDelegateSet_r4(p,d);
        updateInitialBalanceOnInsertDelegateSet_r2(d);
        emit DelegateSet(p,d);
        return true;
      }
      return false;
  }
  function updateInitialBalanceOnInsertDelegateSet_r0(address p) private    {
      updateOutValOnInsertInitialBalance_r8(p);
      updateInValOnInsertInitialBalance_r15(p);
      updateTotalInitialOnInsertInitialBalance_r7(p,uint(0));
  }
  function updateInitialBalanceOnInsertConstructor_r19(address p,uint n) private    {
      updateOutValOnInsertInitialBalance_r8(p);
      updateTotalInitialOnInsertInitialBalance_r7(p,n);
      updateInValOnInsertInitialBalance_r15(p);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateVoteContributionOnInsertDelegates_r13(address p,address d) private    {
      uint n = balanceOf[p].n;
      updateVotesOnInsertVoteContribution_r1(d,n);
  }
  function updateInitialBalanceOnInsertDelegateSet_r2(address p) private    {
      updateOutValOnInsertInitialBalance_r8(p);
      updateInValOnInsertInitialBalance_r15(p);
      updateTotalInitialOnInsertInitialBalance_r7(p,uint(0));
  }
  function updateVoteContributionOnInsertBalanceOf_r13(address p,uint n) private    {
      address d = delegates[p].d;
      updateVotesOnInsertVoteContribution_r1(d,n);
  }
  function updateBalanceOfOnIncrementTotalOut_r14(address p,int o) private    {
      int delta0 = int(-o);
      updateVoteContributionOnIncrementBalanceOf_r13(p,delta0);
      int _delta = int(-o);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalOutOnInsertOutVal_r21(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r14(p,delta0);
  }
  function updateInitialBalanceOnInsertTransfer_r11(address p) private    {
      updateOutValOnInsertInitialBalance_r8(p);
      updateInValOnInsertInitialBalance_r15(p);
      updateTotalInitialOnInsertInitialBalance_r7(p,uint(0));
  }
  function updateTransferOnInsertRecv_transfer_r10(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[s].n;
      if(s!=address(0) && r!=address(0) && n>0 && m>=n) {
        updateInitialBalanceOnInsertTransfer_r11(s);
        updateInValOnInsertTransfer_r12(r,n);
        updateInitialBalanceOnInsertTransfer_r17(r);
        updateOutValOnInsertTransfer_r5(s,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateOutValOnInsertTransfer_r5(address p,uint n) private    {
      updateTotalOutOnInsertOutVal_r21(p,n);
  }
  function updateVotesOnInsertVoteContribution_r1(address d,uint n) private    {
      votes[d].n += n;
  }
}