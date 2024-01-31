contract Erc1155 {
  struct SpentTotalTuple {
    uint m;
    bool _valid;
  }
  struct TotalBurnTuple {
    uint n;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct AllMintTuple {
    uint n;
    bool _valid;
  }
  struct TotalOutTuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct AllBurnTuple {
    uint n;
    bool _valid;
  }
  struct TotalInTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTotalTuple {
    uint m;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  struct TotalMintTuple {
    uint n;
    bool _valid;
  }
  struct IsApprovedForAllTuple {
    bool approval;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  mapping(uint=>mapping(address=>TotalOutTuple)) totalOut;
  mapping(uint=>mapping(address=>mapping(address=>SpentTotalTuple))) spentTotal;
  mapping(uint=>mapping(address=>TotalInTuple)) totalIn;
  mapping(uint=>mapping(address=>mapping(address=>AllowanceTotalTuple))) allowanceTotal;
  mapping(uint=>mapping(address=>TotalBurnTuple)) totalBurn;
  mapping(uint=>mapping(address=>BalanceOfTuple)) balanceOf;
  mapping(uint=>AllMintTuple) allMint;
  OwnerTuple owner;
  mapping(uint=>AllBurnTuple) allBurn;
  mapping(uint=>mapping(address=>mapping(address=>AllowanceTuple))) allowance;
  mapping(uint=>mapping(address=>TotalMintTuple)) totalMint;
  mapping(address=>mapping(address=>IsApprovedForAllTuple)) isApprovedForAll;
  mapping(uint=>TotalSupplyTuple) totalSupply;
  event Burn(uint tokenId,address p,uint amount);
  event SetApprovalForAll(address sender,address operator,bool approved);
  event Transfer(uint tokenId,address from,address to,uint amount);
  event Mint(uint tokenId,address p,uint amount);
  event IncreaseAllowance(uint tokenId,address p,address s,uint n);
  constructor() public {
    updateOwnerOnInsertConstructor_r8();
  }
  function approve(uint tokenId,address s,uint n) public    {
      bool r1 = updateIncreaseAllowanceOnInsertRecv_approve_r1(tokenId,s,n);
      if(r1==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(uint tokenId,address from,address to,uint amount) public    {
      bool r20 = updateTransferFromOnInsertRecv_transferFrom_r20(tokenId,from,to,amount);
      if(r20==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(uint tokenId,address p,address s) public view  returns (uint) {
      uint n = allowance[tokenId][p][s].n;
      return n;
  }
  function getIsApprovedForAll(address owner,address operator) public view  returns (bool) {
      bool approval = isApprovedForAll[owner][operator].approval;
      return approval;
  }
  function burn(uint tokenId,address p,uint amount) public    {
      bool r6 = updateBurnOnInsertRecv_burn_r6(tokenId,p,amount);
      if(r6==false) {
        revert("Rule condition failed");
      }
  }
  function safeTransferFrom(address f,address t,uint id,uint amount,uint data) public    {
      revert("Rule condition failed");
  }
  function mint(uint tokenId,address p,uint amount) public    {
      bool r9 = updateMintOnInsertRecv_mint_r9(tokenId,p,amount);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(uint tokenId,address to,uint amount) public    {
      bool r11 = updateTransferOnInsertRecv_transfer_r11(tokenId,to,amount);
      if(r11==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply(uint tokenId) public view  returns (uint) {
      uint n = totalSupply[tokenId].n;
      return n;
  }
  function getBalanceOf(uint tokenId,address p) public view  returns (uint) {
      uint n = balanceOf[tokenId][p].n;
      return n;
  }
  function updateBalanceOfOnIncrementTotalMint_r3(uint t,address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[t][p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r3(t,p,newValue);
  }
  function updateTotalBurnOnInsertBurn_r7(uint t,address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r3(t,p,delta1);
      totalBurn[t][p].n += n;
  }
  function updateTotalSupplyOnInsertAllBurn_r12(uint t,uint b) private    {
      AllBurnTuple memory toDelete = allBurn[t];
      if(toDelete._valid==true) {
        updateTotalSupplyOnDeleteAllBurn_r12(t,toDelete.n);
      }
      uint m = allMint[t].n;
      uint n = m-b;
      totalSupply[t] = TotalSupplyTuple(n,true);
  }
  function updateBalanceOfOnIncrementTotalIn_r3(uint t,address p,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(totalIn[t][p].n,_delta);
      updateBalanceOfOnInsertTotalIn_r3(t,p,newValue);
  }
  function updateAllMintOnInsertMint_r16(uint t,uint n) private    {
      int delta2 = int(n);
      updateTotalSupplyOnIncrementAllMint_r12(t,delta2);
      allMint[t].n += n;
  }
  function updateAllowanceOnDeleteSpentTotal_r0(uint t,address o,address s,uint l) private    {
      uint m = allowanceTotal[t][o][s].m;
      uint n = m-l;
      if(n==allowance[t][o][s].n) {
        allowance[t][o][s] = AllowanceTuple(0,false);
      }
  }
  function updateBalanceOfOnInsertTotalBurn_r3(uint t,address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r3(t,p,toDelete.n);
      }
      uint i = totalIn[t][p].n;
      uint o = totalOut[t][p].n;
      uint n = totalMint[t][p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnDeleteTotalBurn_r3(uint t,address p,uint m) private    {
      uint i = totalIn[t][p].n;
      uint o = totalOut[t][p].n;
      uint n = totalMint[t][p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[t][p].n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalMintOnInsertMint_r15(uint t,address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalMint_r3(t,p,delta2);
      totalMint[t][p].n += n;
  }
  function updateTotalOutOnInsertTransfer_r14(uint t,address p,uint n) private    {
      int delta2 = int(n);
      updateBalanceOfOnIncrementTotalOut_r3(t,p,delta2);
      totalOut[t][p].n += n;
  }
  function updateAllowanceOnInsertSpentTotal_r0(uint t,address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[t][o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r0(t,o,s,toDelete.m);
      }
      uint m = allowanceTotal[t][o][s].m;
      uint n = m-l;
      allowance[t][o][s] = AllowanceTuple(n,true);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r18(uint t,address o,address s,uint n) private    {
      int delta2 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r0(t,o,s,delta2);
      allowanceTotal[t][o][s].m += n;
  }
  function updateTotalSupplyOnDeleteAllBurn_r12(uint t,uint b) private    {
      uint m = allMint[t].n;
      uint n = m-b;
      if(n==totalSupply[t].n) {
        totalSupply[t] = TotalSupplyTuple(0,false);
      }
  }
  function updateMintOnInsertRecv_mint_r9(uint t,address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(p!=address(0)) {
          updateAllMintOnInsertMint_r16(t,n);
          updateTotalMintOnInsertMint_r15(t,p,n);
          emit Mint(t,p,n);
          return true;
        }
      }
      return false;
  }
  function updateAllowanceOnDeleteAllowanceTotal_r0(uint t,address o,address s,uint m) private    {
      uint l = spentTotal[t][o][s].m;
      uint n = m-l;
      if(n==allowance[t][o][s].n) {
        allowance[t][o][s] = AllowanceTuple(0,false);
      }
  }
  function updateBalanceOfOnDeleteTotalMint_r3(uint t,address p,uint n) private    {
      uint i = totalIn[t][p].n;
      uint o = totalOut[t][p].n;
      uint m = totalBurn[t][p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[t][p].n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateBalanceOfOnIncrementTotalBurn_r3(uint t,address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[t][p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r3(t,p,newValue);
  }
  function updateBalanceOfOnInsertTotalIn_r3(uint t,address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r3(t,p,toDelete.n);
      }
      uint o = totalOut[t][p].n;
      uint m = totalBurn[t][p].n;
      uint n = totalMint[t][p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateOwnerOnInsertConstructor_r8() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateBalanceOfOnInsertTotalMint_r3(uint t,address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r3(t,p,toDelete.n);
      }
      uint i = totalIn[t][p].n;
      uint o = totalOut[t][p].n;
      uint m = totalBurn[t][p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateSpentTotalOnInsertTransferFrom_r19(uint t,address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r0(t,o,s,delta0);
      spentTotal[t][o][s].m += n;
  }
  function updateBalanceOfOnInsertTotalOut_r3(uint t,address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r3(t,p,toDelete.n);
      }
      uint i = totalIn[t][p].n;
      uint m = totalBurn[t][p].n;
      uint n = totalMint[t][p].n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateTransferOnInsertRecv_transfer_r11(uint t,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint m = balanceOf[t][s].n;
      if(n<=m) {
        updateTotalInOnInsertTransfer_r17(t,r,n);
        updateTotalOutOnInsertTransfer_r14(t,s,n);
        emit Transfer(t,s,r,n);
        return true;
      }
      return false;
  }
  function updateAllBurnOnInsertBurn_r5(uint t,uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r12(t,delta0);
      allBurn[t].n += n;
  }
  function updateAllowanceOnIncrementAllowanceTotal_r0(uint t,address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowanceTotal[t][o][s].m,_delta);
      updateAllowanceOnInsertAllowanceTotal_r0(t,o,s,newValue);
  }
  function updateBurnOnInsertRecv_burn_r6(uint t,address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        uint m = balanceOf[t][p].n;
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r7(t,p,n);
          updateAllBurnOnInsertBurn_r5(t,n);
          emit Burn(t,p,n);
          return true;
        }
      }
      return false;
  }
  function updateTotalInOnInsertTransfer_r17(uint t,address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalIn_r3(t,p,delta1);
      totalIn[t][p].n += n;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r20(uint t,address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      uint k = allowance[t][o][s].n;
      uint m = balanceOf[t][o].n;
      if(m>=n && k>=n) {
        updateSpentTotalOnInsertTransferFrom_r19(t,o,s,n);
        updateTransferOnInsertTransferFrom_r10(t,o,r,n);
        return true;
      }
      return false;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r1(uint t,address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[t][o][s].n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r18(t,o,s,d);
      emit IncreaseAllowance(t,o,s,d);
      return true;
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r12(uint t,int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn[t].n,_delta);
      updateTotalSupplyOnInsertAllBurn_r12(t,newValue);
  }
  function updateAllowanceOnInsertAllowanceTotal_r0(uint t,address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[t][o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r0(t,o,s,toDelete.m);
      }
      uint l = spentTotal[t][o][s].m;
      uint n = m-l;
      allowance[t][o][s] = AllowanceTuple(n,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBalanceOfOnDeleteTotalOut_r3(uint t,address p,uint o) private    {
      uint i = totalIn[t][p].n;
      uint m = totalBurn[t][p].n;
      uint n = totalMint[t][p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[t][p].n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalSupplyOnDeleteAllMint_r12(uint t,uint m) private    {
      uint b = allBurn[t].n;
      uint n = m-b;
      if(n==totalSupply[t].n) {
        totalSupply[t] = TotalSupplyTuple(0,false);
      }
  }
  function updateAllowanceOnIncrementSpentTotal_r0(uint t,address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[t][o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r0(t,o,s,newValue);
  }
  function updateTotalSupplyOnInsertAllMint_r12(uint t,uint m) private    {
      AllMintTuple memory toDelete = allMint[t];
      if(toDelete._valid==true) {
        updateTotalSupplyOnDeleteAllMint_r12(t,toDelete.n);
      }
      uint b = allBurn[t].n;
      uint n = m-b;
      totalSupply[t] = TotalSupplyTuple(n,true);
  }
  function updateTotalSupplyOnIncrementAllMint_r12(uint t,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allMint[t].n,_delta);
      updateTotalSupplyOnInsertAllMint_r12(t,newValue);
  }
  function updateTransferOnInsertTransferFrom_r10(uint t,address o,address r,uint n) private    {
      updateTotalInOnInsertTransfer_r17(t,r,n);
      updateTotalOutOnInsertTransfer_r14(t,o,n);
      emit Transfer(t,o,r,n);
  }
  function updateBalanceOfOnDeleteTotalIn_r3(uint t,address p,uint i) private    {
      uint o = totalOut[t][p].n;
      uint m = totalBurn[t][p].n;
      uint n = totalMint[t][p].n;
      uint s = ((n+i)-m)-o;
      if(s==balanceOf[t][p].n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateBalanceOfOnIncrementTotalOut_r3(uint t,address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[t][p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r3(t,p,newValue);
  }
}