contract UniswapFactory {
  struct AllPairsLengthTuple {
    uint n;
    bool _valid;
  }
  struct FeeToSetterTuple {
    address p;
    bool _valid;
  }
  struct PairExistsTuple {
    bool b;
    bool _valid;
  }
  struct FeeToTuple {
    address p;
    bool _valid;
  }
  FeeToTuple feeTo;
  AllPairsLengthTuple allPairsLength;
  FeeToSetterTuple feeToSetter;
  mapping(address=>mapping(address=>PairExistsTuple)) pairExists;
  event CreatePair(address tokenA,address tokenB);
  event SetFeeTo(address p);
  event SetFeeToSetter(address p);
  constructor(address feeSetter) public {
    updateAllPairsLengthOnInsertConstructor_r9();
    updateFeeToOnInsertConstructor_r1();
    updateFeeToSetterOnInsertConstructor_r8(feeSetter);
  }
  function getAllPairsLength() public view  returns (uint) {
      uint n = allPairsLength.n;
      return n;
  }
  function getFeeToSetter() public view  returns (address) {
      address p = feeToSetter.p;
      return p;
  }
  function createPair(address tokenA,address tokenB) public    {
      bool r4 = updateCreatePairOnInsertRecv_createPair_r4(tokenA,tokenB);
      if(r4==false) {
        revert("Rule condition failed");
      }
  }
  function setFeeToSetter(address feeToSetter) public    {
      bool r7 = updateSetFeeToSetterOnInsertRecv_setFeeToSetter_r7(feeToSetter);
      if(r7==false) {
        revert("Rule condition failed");
      }
  }
  function getPairExists(address tokenA,address tokenB) public view  returns (bool) {
      bool b = pairExists[tokenA][tokenB].b;
      return b;
  }
  function getFeeTo() public view  returns (address) {
      address p = feeTo.p;
      return p;
  }
  function setFeeTo(address feeTo) public    {
      bool r2 = updateSetFeeToOnInsertRecv_setFeeTo_r2(feeTo);
      if(r2==false) {
        revert("Rule condition failed");
      }
  }
  function updateFeeToSetterOnInsertConstructor_r8(address p) private    {
      feeToSetter = FeeToSetterTuple(p,true);
  }
  function updateSetFeeToOnInsertRecv_setFeeTo_r2(address p) private   returns (bool) {
      address s = feeToSetter.p;
      if(s==msg.sender) {
        updateFeeToOnInsertSetFeeTo_r5(p);
        emit SetFeeTo(p);
        return true;
      }
      return false;
  }
  function updateFeeToSetterOnInsertSetFeeToSetter_r10(address p) private    {
      feeToSetter = FeeToSetterTuple(p,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateFeeToOnInsertConstructor_r1() private    {
      feeTo = FeeToTuple(address(0),true);
  }
  function updateAllPairsLengthOnInsertConstructor_r9() private    {
      allPairsLength = AllPairsLengthTuple(0,true);
  }
  function updateSetFeeToSetterOnInsertRecv_setFeeToSetter_r7(address p) private   returns (bool) {
      address s = feeToSetter.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateFeeToSetterOnInsertSetFeeToSetter_r10(p);
          emit SetFeeToSetter(p);
          return true;
        }
      }
      return false;
  }
  function updatePairExistsOnInsertCreatePair_r6(address a,address b) private    {
      pairExists[b][a] = PairExistsTuple(true,true);
  }
  function updateCreatePairOnInsertRecv_createPair_r4(address a,address b) private   returns (bool) {
      if(a!=b && a!=address(0) && b!=address(0)) {
        updatePairExistsOnInsertCreatePair_r0(a,b);
        updateAllPairsLengthOnInsertCreatePair_r3(a,b);
        updatePairExistsOnInsertCreatePair_r6(a,b);
        emit CreatePair(a,b);
        return true;
      }
      return false;
  }
  function updatePairExistsOnInsertCreatePair_r0(address a,address b) private    {
      pairExists[a][b] = PairExistsTuple(true,true);
  }
  function updateFeeToOnInsertSetFeeTo_r5(address p) private    {
      feeTo = FeeToTuple(p,true);
  }
  function updateAllPairsLengthOnInsertCreatePair_r3(address _tokenA0,address _tokenB1) private    {
      allPairsLength.n += 1;
  }
}