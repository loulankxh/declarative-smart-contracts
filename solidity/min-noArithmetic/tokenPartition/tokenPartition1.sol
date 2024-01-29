contract TokenPartition {
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct IssueTotalByPartitionTuple {
    uint n;
    bool _valid;
  }
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct TotalMintTuple {
    uint n;
    bool _valid;
  }
  struct AllBurnTuple {
    uint n;
    bool _valid;
  }
  struct RedeemTotalByPartitionTuple {
    uint n;
    bool _valid;
  }
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct AllMintTuple {
    uint n;
    bool _valid;
  }
  mapping(address=>mapping(uint=>TotalOutTuple)) totalOut;
  OwnerTuple owner;
  mapping(address=>mapping(uint=>TotalBurnTuple)) totalBurn;
  mapping(uint=>IssueTotalByPartitionTuple) issueTotalByPartition;
  AllMintTuple allMint;
  mapping(address=>mapping(uint=>TotalInTuple)) totalIn;
  mapping(address=>mapping(uint=>TotalMintTuple)) totalMint;
  AllBurnTuple allBurn;
  mapping(uint=>RedeemTotalByPartitionTuple) redeemTotalByPartition;
  event TransferByPartition(address from,address to,uint q,uint amount);
  event IssueByPartition(address p,uint q,uint amount);
  event RedeemByPartition(address p,uint q,uint amount);
  constructor() public {
    updateOwnerOnInsertConstructor_r11();
    updateTotalSupplyOnInsertConstructor_r3();
  }
  function redeemByPartition(address p,uint q,uint amount) public    {
      bool r9 = updateRedeemByPartitionOnInsertRecv_redeemByPartition_r9(p,q,amount);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function issueByPartition(address p,uint q,uint amount) public    {
      bool r1 = updateIssueByPartitionOnInsertRecv_issueByPartition_r1(p,q,amount);
      if(r1==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply();
      return n;
  }
  function getBalanceOfByPartition(address p,uint q) public view  returns (uint) {
      uint n = balanceOfByPartition(p,q);
      return n;
  }
  function transferByPartition(address to,uint q,uint amount) public    {
      bool r17 = updateTransferByPartitionOnInsertRecv_transferByPartition_r17(to,q,amount);
      if(r17==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupplyByPartition(uint q) public view  returns (uint) {
      uint n = totalSupplyByPartition(q);
      return n;
  }
  function updateTotalMintOnInsertIssueByPartition_r8(address p,uint q,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfByPartitionOnIncrementTotalMint_r16(p,q,delta1);
      totalMint[p][q].n += n;
  }
  function updateTotalSupplyByPartitionOnInsertIssueTotalByPartition_r4(uint q,uint i) private    {
      IssueTotalByPartitionTuple memory toDelete = issueTotalByPartition[q];
      if(toDelete._valid==true) {
        updateTotalSupplyByPartitionOnDeleteIssueTotalByPartition_r4(q,toDelete.n);
      }
      uint r = redeemTotalByPartition[q].n;
      uint n = i-r;
  }
  function updateTotalSupplyByPartitionOnIncrementRedeemTotalByPartition_r4(uint q,int r) private    {
      int _delta = int(r);
      uint newValue = updateuintByint(redeemTotalByPartition[q].n,_delta);
      updateTotalSupplyByPartitionOnInsertRedeemTotalByPartition_r4(q,newValue);
  }
  function updateAllMintOnInsertIssueByPartition_r0(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllMint_r7(delta1);
      allMint.n += n;
  }
  function updateTotalSupplyOnIncrementAllBurn_r7(int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r7(newValue);
  }
  function updateTotalSupplyByPartitionOnDeleteRedeemTotalByPartition_r4(uint q,uint r) private    {
      uint i = issueTotalByPartition[q].n;
      uint n = i-r;
  }
  function updateBalanceOfByPartitionOnInsertTotalIn_r16(address p,uint q,uint i) private    {
      TotalInTuple memory toDelete = totalIn[p][q];
      if(toDelete._valid==true) {
        updateBalanceOfByPartitionOnDeleteTotalIn_r16(p,q,toDelete.n);
      }
      uint o = totalOut[p][q].n;
      uint m = totalBurn[p][q].n;
      uint n = totalMint[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function balanceOfByPartition(address p,uint q) private view  returns (uint) {
      uint i = totalIn[p][q].n;
      uint o = totalOut[p][q].n;
      uint m = totalBurn[p][q].n;
      uint n = totalMint[p][q].n;
      uint s = ((n+i)-m)-o;
      return s;
  }
  function updateBalanceOfByPartitionOnIncrementTotalMint_r16(address p,uint q,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[p][q].n,_delta);
      updateBalanceOfByPartitionOnInsertTotalMint_r16(p,q,newValue);
  }
  function updateBalanceOfByPartitionOnDeleteTotalBurn_r16(address p,uint q,uint m) private    {
      uint i = totalIn[p][q].n;
      uint o = totalOut[p][q].n;
      uint n = totalMint[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function updateBalanceOfByPartitionOnDeleteTotalIn_r16(address p,uint q,uint i) private    {
      uint o = totalOut[p][q].n;
      uint m = totalBurn[p][q].n;
      uint n = totalMint[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function updateBalanceOfByPartitionOnDeleteTotalOut_r16(address p,uint q,uint o) private    {
      uint i = totalIn[p][q].n;
      uint m = totalBurn[p][q].n;
      uint n = totalMint[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function updateTotalOutOnInsertTransferByPartition_r6(address p,uint q,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfByPartitionOnIncrementTotalOut_r16(p,q,delta1);
      totalOut[p][q].n += n;
  }
  function totalSupply() private view  returns (uint) {
      uint b = allBurn.n;
      uint m = allMint.n;
      uint n = m-b;
      return n;
  }
  function updateTransferByPartitionOnInsertRecv_transferByPartition_r17(address r,uint q,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOfByPartition(s,q);
      if(n<=m) {
        updateTotalOutOnInsertTransferByPartition_r6(s,q,n);
        updateTotalInOnInsertTransferByPartition_r15(r,q,n);
        emit TransferByPartition(s,r,q,n);
        return true;
      }
      return false;
  }
  function updateTotalSupplyByPartitionOnDeleteIssueTotalByPartition_r4(uint q,uint i) private    {
      uint r = redeemTotalByPartition[q].n;
      uint n = i-r;
  }
  function updateBalanceOfByPartitionOnInsertTotalBurn_r16(address p,uint q,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[p][q];
      if(toDelete._valid==true) {
        updateBalanceOfByPartitionOnDeleteTotalBurn_r16(p,q,toDelete.n);
      }
      uint i = totalIn[p][q].n;
      uint o = totalOut[p][q].n;
      uint n = totalMint[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function updateOwnerOnInsertConstructor_r11() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateBalanceOfByPartitionOnIncrementTotalIn_r16(address p,uint q,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[p][q].n,_delta);
      updateBalanceOfByPartitionOnInsertTotalIn_r16(p,q,newValue);
  }
  function updateTotalSupplyOnInsertAllBurn_r7(uint b) private    {
      uint m = allMint.n;
      uint n = m-b;
  }
  function totalSupplyByPartition(uint q) private view  returns (uint) {
      uint r = redeemTotalByPartition[q].n;
      uint i = issueTotalByPartition[q].n;
      uint n = i-r;
      return n;
  }
  function updateBalanceOfByPartitionOnInsertTotalMint_r16(address p,uint q,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[p][q];
      if(toDelete._valid==true) {
        updateBalanceOfByPartitionOnDeleteTotalMint_r16(p,q,toDelete.n);
      }
      uint i = totalIn[p][q].n;
      uint o = totalOut[p][q].n;
      uint m = totalBurn[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function updateRedeemByPartitionOnInsertRecv_redeemByPartition_r9(address p,uint q,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOfByPartition(p,q);
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertRedeemByPartition_r14(p,q,n);
          updateRedeemTotalByPartitionOnInsertRedeemByPartition_r13(q,n);
          updateAllBurnOnInsertRedeemByPartition_r10(n);
          emit RedeemByPartition(p,q,n);
          return true;
        }
      }
      return false;
  }
  function updateAllBurnOnInsertRedeemByPartition_r10(uint n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r7(delta1);
      allBurn.n += n;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateTotalSupplyByPartitionOnInsertRedeemTotalByPartition_r4(uint q,uint r) private    {
      RedeemTotalByPartitionTuple memory toDelete = redeemTotalByPartition[q];
      if(toDelete._valid==true) {
        updateTotalSupplyByPartitionOnDeleteRedeemTotalByPartition_r4(q,toDelete.n);
      }
      uint i = issueTotalByPartition[q].n;
      uint n = i-r;
  }
  function updateIssueTotalByPartitionOnInsertIssueByPartition_r5(uint q,uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyByPartitionOnIncrementIssueTotalByPartition_r4(q,delta0);
      issueTotalByPartition[q].n += n;
  }
  function updateTotalSupplyByPartitionOnIncrementIssueTotalByPartition_r4(uint q,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(issueTotalByPartition[q].n,_delta);
      updateTotalSupplyByPartitionOnInsertIssueTotalByPartition_r4(q,newValue);
  }
  function updateBalanceOfByPartitionOnInsertTotalOut_r16(address p,uint q,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[p][q];
      if(toDelete._valid==true) {
        updateBalanceOfByPartitionOnDeleteTotalOut_r16(p,q,toDelete.n);
      }
      uint i = totalIn[p][q].n;
      uint m = totalBurn[p][q].n;
      uint n = totalMint[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function updateTotalBurnOnInsertRedeemByPartition_r14(address p,uint q,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfByPartitionOnIncrementTotalBurn_r16(p,q,delta1);
      totalBurn[p][q].n += n;
  }
  function updateTotalInOnInsertTransferByPartition_r15(address p,uint q,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfByPartitionOnIncrementTotalIn_r16(p,q,delta0);
      totalIn[p][q].n += n;
  }
  function updateBalanceOfByPartitionOnIncrementTotalOut_r16(address p,uint q,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[p][q].n,_delta);
      updateBalanceOfByPartitionOnInsertTotalOut_r16(p,q,newValue);
  }
  function updateIssueByPartitionOnInsertRecv_issueByPartition_r1(address p,uint q,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateIssueTotalByPartitionOnInsertIssueByPartition_r5(q,n);
          updateTotalMintOnInsertIssueByPartition_r8(p,q,n);
          updateAllMintOnInsertIssueByPartition_r0(n);
          emit IssueByPartition(p,q,n);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfByPartitionOnDeleteTotalMint_r16(address p,uint q,uint n) private    {
      uint i = totalIn[p][q].n;
      uint o = totalOut[p][q].n;
      uint m = totalBurn[p][q].n;
      uint s = ((n+i)-m)-o;
  }
  function updateRedeemTotalByPartitionOnInsertRedeemByPartition_r13(uint q,uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyByPartitionOnIncrementRedeemTotalByPartition_r4(q,delta0);
      redeemTotalByPartition[q].n += n;
  }
  function updateTotalSupplyOnIncrementAllMint_r7(int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r7(newValue);
  }
  function updateTotalSupplyOnInsertAllMint_r7(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
  }
  function updateBalanceOfByPartitionOnIncrementTotalBurn_r16(address p,uint q,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[p][q].n,_delta);
      updateBalanceOfByPartitionOnInsertTotalBurn_r16(p,q,newValue);
  }
  function updateTotalSupplyOnInsertConstructor_r3() private    {
      // Empty()
  }
}