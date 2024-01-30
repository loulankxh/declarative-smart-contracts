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
  function getBalanceOf(uint tokenId,address p) public view  returns (uint) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[tokenId][p];
      uint n = balanceOfTuple.n;
      return n;
  }
  function getTotalSupply(uint tokenId) public view  returns (uint) {
      TotalSupplyTuple memory totalSupplyTuple = totalSupply[tokenId];
      uint n = totalSupplyTuple.n;
      return n;
  }
  function getAllowance(uint tokenId,address p,address s) public view  returns (uint) {
      AllowanceTuple memory allowanceTuple = allowance[tokenId][p][s];
      uint n = allowanceTuple.n;
      return n;
  }
  function getIsApprovedForAll(address owner,address operator) public view  returns (bool) {
      IsApprovedForAllTuple memory isApprovedForAllTuple = isApprovedForAll[owner][operator];
      bool approval = isApprovedForAllTuple.approval;
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
  function updateBalanceOfOnIncrementTotalMint_r3(uint t,address p,int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalMint[t][p].n,_delta);
      updateBalanceOfOnInsertTotalMint_r3(t,p,newValue);
  }
  function updateBurnOnInsertRecv_burn_r6(uint t,address p,uint n) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        BalanceOfTuple memory balanceOfTuple = balanceOf[p][t];
        uint m = balanceOfTuple.n;
        if(p!=address(0) && n<=m) {
          updateTotalBurnOnInsertBurn_r7(t,p,n);
          updateAllBurnOnInsertBurn_r5(t,n);
          emit Burn(t,p,n);
          return true;
        }
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r8() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateTotalOutOnInsertTransfer_r14(uint t,address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalOut_r3(t,p,delta1);
      totalOut[t][p].n += n;
  }
  function updateBalanceOfOnDeleteTotalIn_r3(uint t,address p,uint i) private    {
      TotalOutTuple memory totalOutTuple = totalOut[p][t];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p][t];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p][t];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[t][p];
      if(s==balanceOfTuple.n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalInOnInsertTransfer_r17(uint t,address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalIn_r3(t,p,delta0);
      totalIn[t][p].n += n;
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
  function updateTotalSupplyOnInsertAllBurn_r12(uint t,uint b) private    {
      AllBurnTuple memory toDelete = allBurn[t];
      if(toDelete._valid==true) {
        updateTotalSupplyOnDeleteAllBurn_r12(t,toDelete.n);
      }
      AllMintTuple memory allMintTuple = allMint[t];
      uint m = allMintTuple.n;
      uint n = m-b;
      totalSupply[t] = TotalSupplyTuple(n,true);
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r1(uint t,address s,uint n) private   returns (bool) {
      address o = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o][t];
      uint m = allowanceTuple.n;
      uint d = n-m;
      updateAllowanceTotalOnInsertIncreaseAllowance_r18(t,o,s,d);
      emit IncreaseAllowance(t,o,s,d);
      return true;
      return false;
  }
  function updateAllowanceOnIncrementSpentTotal_r0(uint t,address o,address s,int l) private    {
      int _delta = int(l);
      uint newValue = updateuintByint(spentTotal[t][o][s].m,_delta);
      updateAllowanceOnInsertSpentTotal_r0(t,o,s,newValue);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r18(uint t,address o,address s,uint n) private    {
      int delta2 = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r0(t,o,s,delta2);
      allowanceTotal[t][o][s].m += n;
  }
  function updateAllowanceOnDeleteAllowanceTotal_r0(uint t,address o,address s,uint m) private    {
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o][t];
      uint l = spentTotalTuple.m;
      uint n = m-l;
      AllowanceTuple memory allowanceTuple = allowance[t][o][s];
      if(n==allowanceTuple.n) {
        allowance[t][o][s] = AllowanceTuple(0,false);
      }
  }
  function updateTotalSupplyOnInsertAllMint_r12(uint t,uint m) private    {
      AllMintTuple memory toDelete = allMint[t];
      if(toDelete._valid==true) {
        updateTotalSupplyOnDeleteAllMint_r12(t,toDelete.n);
      }
      AllBurnTuple memory allBurnTuple = allBurn[t];
      uint b = allBurnTuple.n;
      uint n = m-b;
      totalSupply[t] = TotalSupplyTuple(n,true);
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
  function updateBalanceOfOnIncrementTotalBurn_r3(uint t,address p,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(totalBurn[t][p].n,_delta);
      updateBalanceOfOnInsertTotalBurn_r3(t,p,newValue);
  }
  function updateBalanceOfOnDeleteTotalMint_r3(uint t,address p,uint n) private    {
      TotalInTuple memory totalInTuple = totalIn[p][t];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p][t];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p][t];
      uint m = totalBurnTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[t][p];
      if(s==balanceOfTuple.n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateSpentTotalOnInsertTransferFrom_r19(uint t,address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r0(t,o,s,delta0);
      spentTotal[t][o][s].m += n;
  }
  function updateAllowanceOnInsertAllowanceTotal_r0(uint t,address o,address s,uint m) private    {
      AllowanceTotalTuple memory toDelete = allowanceTotal[t][o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteAllowanceTotal_r0(t,o,s,toDelete.m);
      }
      SpentTotalTuple memory spentTotalTuple = spentTotal[s][o][t];
      uint l = spentTotalTuple.m;
      uint n = m-l;
      allowance[t][o][s] = AllowanceTuple(n,true);
  }
  function updateTotalMintOnInsertMint_r15(uint t,address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalMint_r3(t,p,delta0);
      totalMint[t][p].n += n;
  }
  function updateBalanceOfOnInsertTotalMint_r3(uint t,address p,uint n) private    {
      TotalMintTuple memory toDelete = totalMint[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalMint_r3(t,p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p][t];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p][t];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p][t];
      uint m = totalBurnTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateTotalBurnOnInsertBurn_r7(uint t,address p,uint n) private    {
      int delta1 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r3(t,p,delta1);
      totalBurn[t][p].n += n;
  }
  function updateAllowanceOnDeleteSpentTotal_r0(uint t,address o,address s,uint l) private    {
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o][t];
      uint m = allowanceTotalTuple.m;
      uint n = m-l;
      AllowanceTuple memory allowanceTuple = allowance[t][o][s];
      if(n==allowanceTuple.n) {
        allowance[t][o][s] = AllowanceTuple(0,false);
      }
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
  function updateAllowanceOnInsertSpentTotal_r0(uint t,address o,address s,uint l) private    {
      SpentTotalTuple memory toDelete = spentTotal[t][o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteSpentTotal_r0(t,o,s,toDelete.m);
      }
      AllowanceTotalTuple memory allowanceTotalTuple = allowanceTotal[s][o][t];
      uint m = allowanceTotalTuple.m;
      uint n = m-l;
      allowance[t][o][s] = AllowanceTuple(n,true);
  }
  function updateTransferOnInsertRecv_transfer_r11(uint t,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      BalanceOfTuple memory balanceOfTuple = balanceOf[s][t];
      uint m = balanceOfTuple.n;
      if(n<=m) {
        updateTotalInOnInsertTransfer_r17(t,r,n);
        updateTotalOutOnInsertTransfer_r14(t,s,n);
        emit Transfer(t,s,r,n);
        return true;
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r12(uint t,int b) private    {
      int _delta = int(b);
      uint newValue = updateuintByint(allBurn[t].n,_delta);
      updateTotalSupplyOnInsertAllBurn_r12(t,newValue);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBalanceOfOnInsertTotalBurn_r3(uint t,address p,uint m) private    {
      TotalBurnTuple memory toDelete = totalBurn[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalBurn_r3(t,p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p][t];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p][t];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p][t];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnInsertTotalIn_r3(uint t,address p,uint i) private    {
      TotalInTuple memory toDelete = totalIn[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalIn_r3(t,p,toDelete.n);
      }
      TotalOutTuple memory totalOutTuple = totalOut[p][t];
      uint o = totalOutTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p][t];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p][t];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateBalanceOfOnInsertTotalOut_r3(uint t,address p,uint o) private    {
      TotalOutTuple memory toDelete = totalOut[t][p];
      if(toDelete._valid==true) {
        updateBalanceOfOnDeleteTotalOut_r3(t,p,toDelete.n);
      }
      TotalInTuple memory totalInTuple = totalIn[p][t];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p][t];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p][t];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      balanceOf[t][p] = BalanceOfTuple(s,true);
  }
  function updateTotalSupplyOnDeleteAllMint_r12(uint t,uint m) private    {
      AllBurnTuple memory allBurnTuple = allBurn[t];
      uint b = allBurnTuple.n;
      uint n = m-b;
      TotalSupplyTuple memory totalSupplyTuple = totalSupply[t];
      if(n==totalSupplyTuple.n) {
        totalSupply[t] = TotalSupplyTuple(0,false);
      }
  }
  function updateBalanceOfOnDeleteTotalOut_r3(uint t,address p,uint o) private    {
      TotalInTuple memory totalInTuple = totalIn[p][t];
      uint i = totalInTuple.n;
      TotalBurnTuple memory totalBurnTuple = totalBurn[p][t];
      uint m = totalBurnTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p][t];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[t][p];
      if(s==balanceOfTuple.n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateTransferFromOnInsertRecv_transferFrom_r20(uint t,address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      AllowanceTuple memory allowanceTuple = allowance[s][o][t];
      uint k = allowanceTuple.n;
      BalanceOfTuple memory balanceOfTuple = balanceOf[o][t];
      uint m = balanceOfTuple.n;
      if(m>=n && k>=n) {
        updateSpentTotalOnInsertTransferFrom_r19(t,o,s,n);
        updateTransferOnInsertTransferFrom_r10(t,o,r,n);
        return true;
      }
      return false;
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
  function updateBalanceOfOnIncrementTotalOut_r3(uint t,address p,int o) private    {
      int _delta = int(o);
      uint newValue = updateuintByint(totalOut[t][p].n,_delta);
      updateBalanceOfOnInsertTotalOut_r3(t,p,newValue);
  }
  function updateBalanceOfOnDeleteTotalBurn_r3(uint t,address p,uint m) private    {
      TotalInTuple memory totalInTuple = totalIn[p][t];
      uint i = totalInTuple.n;
      TotalOutTuple memory totalOutTuple = totalOut[p][t];
      uint o = totalOutTuple.n;
      TotalMintTuple memory totalMintTuple = totalMint[p][t];
      uint n = totalMintTuple.n;
      uint s = ((n+i)-m)-o;
      BalanceOfTuple memory balanceOfTuple = balanceOf[t][p];
      if(s==balanceOfTuple.n) {
        balanceOf[t][p] = BalanceOfTuple(0,false);
      }
  }
  function updateTotalSupplyOnDeleteAllBurn_r12(uint t,uint b) private    {
      AllMintTuple memory allMintTuple = allMint[t];
      uint m = allMintTuple.n;
      uint n = m-b;
      TotalSupplyTuple memory totalSupplyTuple = totalSupply[t];
      if(n==totalSupplyTuple.n) {
        totalSupply[t] = TotalSupplyTuple(0,false);
      }
  }
}