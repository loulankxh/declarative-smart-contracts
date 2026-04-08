contract UniswapFactory {
  struct AllPairsLengthTuple {
    uint n;
    bool _valid;
  }
  struct FeeToSetterTuple {
    address p;
    bool _valid;
  }
  struct FeeToTuple {
    address p;
    bool _valid;
  }
  AllPairsLengthTuple allPairsLength;
  FeeToTuple feeTo;
  FeeToSetterTuple feeToSetter;
  event CreatePair(address tokenA,address tokenB);
  event SetFeeTo(address p);
  event SetFeeToSetter(address p);
  constructor(address feeSetter) public {
    updateFeeToSetterOnInsertConstructor_r6(feeSetter);
    updateFeeToOnInsertConstructor_r0();
    updateAllPairsLengthOnInsertConstructor_r7();
  }
  function getAllPairsLength() public view  returns (uint) {
      uint n = allPairsLength.n;
      return n;
  }
  function getFeeToSetter() public view  returns (address) {
      address p = feeToSetter.p;
      return p;
  }
  function setFeeToSetter(address feeToSetter) public    {
      bool r5 = updateSetFeeToSetterOnInsertRecv_setFeeToSetter_r5(feeToSetter);
      if(r5==false) {
        revert("Rule condition failed");
      }
  }
  function createPair(address tokenA,address tokenB) public    {
      bool r3 = updateCreatePairOnInsertRecv_createPair_r3(tokenA,tokenB);
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function getFeeTo() public view  returns (address) {
      address p = feeTo.p;
      return p;
  }
  function setFeeTo(address feeTo) public    {
      bool r1 = updateSetFeeToOnInsertRecv_setFeeTo_r1(feeTo);
      if(r1==false) {
        revert("Rule condition failed");
      }
  }
  function updateFeeToOnInsertSetFeeTo_r4(address p) private    {
      feeTo = FeeToTuple(p,true);
  }
  function updateSetFeeToSetterOnInsertRecv_setFeeToSetter_r5(address p) private   returns (bool) {
      address s = feeToSetter.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateFeeToSetterOnInsertSetFeeToSetter_r8(p);
          emit SetFeeToSetter(p);
          return true;
        }
      }
      return false;
  }
  function updateFeeToOnInsertConstructor_r0() private    {
      feeTo = FeeToTuple(address(0),true);
  }
  function updateAllPairsLengthOnInsertConstructor_r7() private    {
      allPairsLength = AllPairsLengthTuple(0,true);
  }
  function updateCreatePairOnInsertRecv_createPair_r3(address a,address b) private   returns (bool) {
      if(a!=b && a!=address(0) && b!=address(0)) {
        updateAllPairsLengthOnInsertCreatePair_r2(a,b);
        emit CreatePair(a,b);
        return true;
      }
      return false;
  }
  function updateAllPairsLengthOnInsertCreatePair_r2(address _tokenA0,address _tokenB1) private    {
      allPairsLength.n += 1;
  }
  function updateFeeToSetterOnInsertSetFeeToSetter_r8(address p) private    {
      feeToSetter = FeeToSetterTuple(p,true);
  }
  function updateFeeToSetterOnInsertConstructor_r6(address p) private    {
      feeToSetter = FeeToSetterTuple(p,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateSetFeeToOnInsertRecv_setFeeTo_r1(address p) private   returns (bool) {
      address s = feeToSetter.p;
      if(s==msg.sender) {
        updateFeeToOnInsertSetFeeTo_r4(p);
        emit SetFeeTo(p);
        return true;
      }
      return false;
  }
}