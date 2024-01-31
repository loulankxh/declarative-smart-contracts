contract VestingWallet {
  struct BeneficiaryTuple {
    address p;
    bool _valid;
  }
  struct DurationTuple {
    uint t;
    bool _valid;
  }
  struct StartTuple {
    uint t;
    bool _valid;
  }
  struct ReleasedTuple {
    uint n;
    bool _valid;
  }
  ReleasedTuple released;
  BeneficiaryTuple beneficiary;
  DurationTuple duration;
  StartTuple start;
  event Release(uint n);
  constructor(uint s,uint d,address b) public {
    updateStartOnInsertConstructor_r6(s);
    updateDurationOnInsertConstructor_r5(d);
    updateBeneficiaryOnInsertConstructor_r4(b);
  }
  function release() public    {
      bool r7 = updateReleaseOnInsertRecv_release_r7();
      bool r3 = updateReleaseOnInsertRecv_release_r3();
      if(r7==false && r3==false) {
        revert("Rule condition failed");
      }
  }
  function getReleased() public view  returns (uint) {
      uint n = released.n;
      return n;
  }
  function updateBeneficiaryOnInsertConstructor_r4(address b) private    {
      beneficiary = BeneficiaryTuple(b,true);
  }
  function updateSendOnInsertRelease_r1(uint n) private    {
      address b = beneficiary.p;
      if(n>0) {
        payable(b).send(n);
      }
  }
  function updateReleasedOnInsertRelease_r0(uint n) private    {
      released.n += n;
  }
  function updateStartOnInsertConstructor_r6(uint s) private    {
      start = StartTuple(s,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateReleaseOnInsertRecv_release_r3() private   returns (bool) {
      uint d = duration.t;
      uint e = released.n;
      uint b = address(this).balance;
      uint a = start.t;
      uint t = block.timestamp;
      if(t>a && t<a+d) {
        uint n = (((b+e)*(t-a))/d)-e;
        updateReleasedOnInsertRelease_r0(n);
        updateSendOnInsertRelease_r1(n);
        emit Release(n);
        return true;
      }
      return false;
  }
  function updateReleaseOnInsertRecv_release_r7() private   returns (bool) {
      uint d = duration.t;
      uint e = released.n;
      uint b = address(this).balance;
      uint a = start.t;
      uint t = block.timestamp;
      if(t>a+d) {
        uint n = b;
        updateReleasedOnInsertRelease_r0(n);
        updateSendOnInsertRelease_r1(n);
        emit Release(n);
        return true;
      }
      return false;
  }
  function updateDurationOnInsertConstructor_r5(uint d) private    {
      duration = DurationTuple(d,true);
  }
}