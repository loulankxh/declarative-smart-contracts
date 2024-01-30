contract Wallet {
  struct AllBurnTuple {
    int n;
    bool _valid;
  }
  struct BalanceOfTuple {
    int n;
    bool _valid;
  }
  struct TotalSupplyTuple {
    int n;
    bool _valid;
  }
  struct AllMintTuple {
    int n;
    bool _valid;
  }
  struct TotalOutTuple {
    int n;
    bool _valid;
  }
  struct TotalInTuple {
    int n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  AllBurnTuple allBurn;
  mapping(address=>BalanceOfTuple) balanceOf;
  TotalSupplyTuple totalSupply;
  AllMintTuple allMint;
  mapping(address=>TotalOutTuple) totalOut;
  mapping(address=>TotalInTuple) totalIn;
  OwnerTuple owner;
  event Transfer(address from,address to,int amount);
  constructor() public {
    updateOwnerOnInsertConstructor_r2();
  }
  function transfer(address from,address to,int amount) public    {
      bool r12 = updateTransferOnInsertRecv_transfer_r12(from,to,amount);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (int) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      int n = balanceOfTuple.n;
      return n;
  }
  function mint(address p,int amount) public    {
      bool r9 = updateMintOnInsertRecv_mint_r9(p,amount);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function burn(address p,int amount) public    {
      bool r3 = updateBurnOnInsertRecv_burn_r3(p,amount);
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (int) {
      int n = totalSupply.n;
      return n;
  }
  function updateBurnOnInsertRecv_burn_r3(address p,int n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        BalanceOfTuple memory balanceOfTuple = balanceOf[p];
        int m = balanceOfTuple.n;
        if(p!=address(0) && n<=m) {
          updateAllBurnOnInsertBurn_r7(n);
          updateTransferOnInsertBurn_r11(p,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalInOnInsertTransfer_r6(address p,int n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r1(p,delta0);
      totalIn[p].n += n;
  }
  function updateTotalOutOnInsertTransfer_r4(address p,int n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOut_r1(p,delta0);
      totalOut[p].n += n;
  }
  function updateAllBurnOnInsertBurn_r7(int n) private    {
      int delta1 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r8(delta1);
      allBurn.n += n;
  }
  function updateBalanceOfOnInsertTotalOut_r1(address p,int o) private    {
      TotalOutTuple memory toDelete = totalOut[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r1(p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p];
      int i = totalInTuple.n;
      int s = i-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBalanceOfOnDeleteTotalOut_r1(address p,int o) private    {
      TotalInTuple memory totalInTuple = totalIn[p];
      int i = totalInTuple.n;
      int s = i-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateBalanceOfOnIncrementTotalIn_r1(address p,int i) private    {
      int _delta = int(i);
      int newValue = updateintByint(totalIn[p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r1(p,newValue);
  }
  function updateintByint(int x,int delta) private   returns (int) {
      int newValue = x+delta;
      return newValue;
  }
  function updateTotalSupplyOnInsertAllMint_r8(int m) private    {
      int b = allBurn.n;
      int n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateBalanceOfOnDeleteTotalIn_r1(address p,int i) private    {
      TotalOutTuple memory totalOutTuple = totalOut[p];
      int o = totalOutTuple.n;
      int s = i-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      if(s==balanceOfTuple.n) {
        balanceOf[p] = BalanceOfTuple(0,false);
      }
  }
  function updateTransferOnInsertMint_r10(address p,int n) private    {
      updateTotalOutOnInsertTransfer_r4(address(0),n);
      updateTotalInOnInsertTransfer_r6(p,n);
      emit Transfer(address(0),p,n);
  }
  function updateOwnerOnInsertConstructor_r2() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateTotalSupplyOnIncrementAllMint_r8(int m) private    {
      int _delta = int(m);
      int newValue = updateintByint(allMint.n,_delta);
      updateTotalSupplyOnInsertAllMint_r8(newValue);
  }
  function updateTransferOnInsertBurn_r11(address p,int n) private    {
      updateTotalOutOnInsertTransfer_r4(p,n);
      updateTotalInOnInsertTransfer_r6(address(0),n);
      emit Transfer(p,address(0),n);
  }
  function updateBalanceOfOnInsertTotalIn_r1(address p,int i) private    {
      TotalInTuple memory toDelete = totalIn[p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r1(p,toDelete.n);
      }
      TotalOutTuple memory totalOutTuple = totalOut[p];
      int o = totalOutTuple.n;
      int s = i-o;
      balanceOf[p] = BalanceOfTuple(s,true);
  }
  function updateMintOnInsertRecv_mint_r9(address p,int n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(n>0 && p!=address(0)) {
          updateTransferOnInsertMint_r10(p,n);
          updateAllMintOnInsertMint_r0(n);
          return true;
        }
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalOut_r1(address p,int o) private    {
      int _delta = int(o);
      int newValue = updateintByint(totalOut[p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r1(p,newValue);
  }
  function updateAllMintOnInsertMint_r0(int n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllMint_r8(delta0);
      allMint.n += n;
  }
  function updateTransferOnInsertRecv_transfer_r12(address s,address r,int n) private   returns (bool) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[s];
      int m = balanceOfTuple.n;
      if(m>=n && n>0) {
        updateTotalInOnInsertTransfer_r6(r,n);
        updateTotalOutOnInsertTransfer_r4(s,n);
        emit Transfer(s,r,n);
        return true;
      }
      return false;
  }
  function updateTotalSupplyOnInsertAllBurn_r8(int b) private    {
      int m = allMint.n;
      int n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTotalSupplyOnIncrementAllBurn_r8(int b) private    {
      int _delta = int(b);
      int newValue = updateintByint(allBurn.n,_delta);
      updateTotalSupplyOnInsertAllBurn_r8(newValue);
  }
}