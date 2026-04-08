contract Pepe {
  struct MinHoldingAmountTuple {
    uint n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct LimitedTuple {
    bool b;
    bool _valid;
  }
  struct MaxHoldingAmountTuple {
    uint n;
    bool _valid;
  }
  struct SpentTotalTuple {
    uint n;
    bool _valid;
  }
  struct DecreaseAllowanceTotalTuple {
    uint n;
    bool _valid;
  }
  struct BlacklistsTuple {
    bool b;
    bool _valid;
  }
  struct IncreaseAllowanceTotalTuple {
    uint n;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  struct AllBurnTuple {
    uint n;
    bool _valid;
  }
  struct UniswapV2PairTuple {
    address p;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  MinHoldingAmountTuple minHoldingAmount;
  TotalSupplyTuple totalSupply;
  LimitedTuple limited;
  MaxHoldingAmountTuple maxHoldingAmount;
  OwnerTuple owner;
  mapping(address=>mapping(address=>SpentTotalTuple)) spentTotal;
  mapping(address=>mapping(address=>DecreaseAllowanceTotalTuple)) decreaseAllowanceTotal;
  mapping(address=>BlacklistsTuple) blacklists;
  mapping(address=>mapping(address=>IncreaseAllowanceTotalTuple)) increaseAllowanceTotal;
  mapping(address=>BalanceOfTuple) balanceOf;
  AllBurnTuple allBurn;
  UniswapV2PairTuple uniswapV2Pair;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  event Participant(address p);
  event Approve(address o,address s,uint n);
  event DecreaseAllowance(address p,address s,uint n);
  event IncreaseAllowance(address p,address s,uint n);
  event SetRuleAction(bool b,address pair,uint max,uint min);
  constructor(uint totalSupply) public {
    updateParticipantOnInsertConstructor_r6();
    updateUniswapV2PairOnInsertConstructor_r59();
    updateBalanceOfOnInsertConstructor_r49(totalSupply);
    updateMaxHoldingAmountOnInsertConstructor_r20();
    updateMinHoldingAmountOnInsertConstructor_r28();
    updateOwnerOnInsertConstructor_r21();
    updateTotalSupplyOnInsertConstructor_r51(totalSupply);
    updateInitialMintOnInsertConstructor_r46(totalSupply);
    updateLimitedOnInsertConstructor_r48();
    updateTotalSupplyOnInsertConstructor_r17(totalSupply);
  }
  function getUniswapV2Pair() public view  returns (address) {
      address p = uniswapV2Pair.p;
      return p;
  }
  function decreaseAllowance(address s,uint n) public    {
      bool r8 = updateParticipantOnInsertRecv_decreaseAllowance_r8(s);
      bool r38 = updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r38(s,n);
      if(r8==false && r38==false) {
        revert("Rule condition failed");
      }
  }
  function getBlacklists(address p) public view  returns (bool) {
      bool b = blacklists[p].b;
      return b;
  }
  function burn(uint amount) public    {
      bool r31 = updateBurnOnInsertRecv_burn_r31(amount);
      if(r31==false) {
        revert("Rule condition failed");
      }
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function transferFrom(address from,address to,uint amount) public    {
      bool r11 = updateParticipantOnInsertRecv_transferFrom_r11(to);
      bool r55 = updateTransferFromOnInsertRecv_transferFrom_r55(from,to,amount);
      bool r24 = updateParticipantOnInsertRecv_transferFrom_r24(from);
      bool r30 = updateTransferFromOnInsertRecv_transferFrom_r30(from,to,amount);
      bool r26 = updateTransferFromOnInsertRecv_transferFrom_r26(from,to,amount);
      bool r0 = updateTransferFromOnInsertRecv_transferFrom_r0(from,to,amount);
      bool r47 = updateTransferFromOnInsertRecv_transferFrom_r47(from,to,amount);
      if(r30==false && r0==false && r55==false && r24==false && r47==false && r11==false && r26==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      uint n = allowance[p][s].n;
      return n;
  }
  function getBalanceOf(address p) public view  returns (uint) {
      uint n = balanceOf[p].n;
      return n;
  }
  function transfer(address to,uint amount) public    {
      bool r61 = updateTransferOnInsertRecv_transfer_r61(to,amount);
      bool r40 = updateParticipantOnInsertRecv_transfer_r40(to);
      bool r54 = updateTransferOnInsertRecv_transfer_r54(to,amount);
      bool r13 = updateTransferOnInsertRecv_transfer_r13(to,amount);
      bool r43 = updateTransferOnInsertRecv_transfer_r43(to,amount);
      bool r3 = updateTransferOnInsertRecv_transfer_r3(to,amount);
      if(r61==false && r54==false && r13==false && r40==false && r43==false && r3==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address s,uint n) public    {
      bool r22 = updateParticipantOnInsertRecv_approve_r22(s);
      bool r57 = updateApproveOnInsertRecv_approve_r57(s,n);
      if(r22==false && r57==false) {
        revert("Rule condition failed");
      }
  }
  function blacklist(address p,bool b) public    {
      bool r35 = updateParticipantOnInsertRecv_blacklist_r35(p);
      bool r1 = updateBlacklistActionOnInsertRecv_blacklist_r1(p,b);
      if(r35==false && r1==false) {
        revert("Rule condition failed");
      }
  }
  function getLimited() public view  returns (bool) {
      bool b = limited.b;
      return b;
  }
  function increaseAllowance(address s,uint n) public    {
      bool r45 = updateParticipantOnInsertRecv_increaseAllowance_r45(s);
      bool r53 = updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r53(s,n);
      if(r45==false && r53==false) {
        revert("Rule condition failed");
      }
  }
  function setRule(bool b,address pair,uint max,uint min) public    {
      bool r5 = updateParticipantOnInsertRecv_setRule_r5(pair);
      bool r32 = updateSetRuleActionOnInsertRecv_setRule_r32(b,pair,max,min);
      if(r5==false && r32==false) {
        revert("Rule condition failed");
      }
  }
  function updateTransferOnInsertRecv_transfer_r54(address r,uint n) private   returns (bool) {
      address p = uniswapV2Pair.p;
      address s = msg.sender;
      if(false==limited.b) {
        uint m = balanceOf[s].n;
        if(false==blacklists[r].b) {
          if(false==blacklists[s].b) {
            if(n<=m && s!=address(0) && r!=address(0) && p!=address(0)) {
              updateParticipantOnInsertTransfer_r58(r);
              updateTotalInTransferOnInsertTransfer_r34(r,n);
              updateTotalOutTransferOnInsertTransfer_r41(s,n);
              updateParticipantOnInsertTransfer_r29(s);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r51(int b) private    {
      int _delta = int(-b);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function updateParticipantOnInsertRecv_setRule_r5(address p) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
      return true;
      return false;
  }
  function updateTotalOutTransferOnInsertTransfer_r41(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOutTransfer_r33(p,delta0);
  }
  function updateDecreaseAllowanceOnInsertRecv_decreaseAllowance_r38(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      uint m = allowance[o][s].n;
      if(o!=address(0) && s!=address(0) && m>=n) {
        updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r9(o,s,n);
        emit DecreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
  function updateBlacklistsOnInsertParticipant_r50(address p) private    {
      blacklists[p] = BlacklistsTuple(false,true);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r26(address o,address r,uint n) private   returns (bool) {
      address p = uniswapV2Pair.p;
      address s = msg.sender;
      if(true==limited.b) {
        if(false==blacklists[o].b) {
          uint m = balanceOf[o].n;
          if(false==blacklists[r].b) {
            uint k = allowance[o][s].n;
            if(r!=address(0) && p!=address(0) && n<=m && n<=k && o!=address(0) && o!=p) {
              updateTotalOutTransferFromOnInsertTransferFrom_r18(o,n);
              updateSpentTotalOnInsertTransferFrom_r12(o,s,n);
              updateParticipantOnInsertTransferFrom_r19(o);
              updateTotalInTransferFromOnInsertTransferFrom_r56(r,n);
              updateParticipantOnInsertTransferFrom_r37(s);
              updateParticipantOnInsertTransferFrom_r25(r);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateTransferOnInsertRecv_transfer_r43(address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(address(0)==uniswapV2Pair.p) {
        if(s==owner.p) {
          uint m = balanceOf[s].n;
          if(false==blacklists[r].b) {
            if(false==blacklists[s].b) {
              if(n<=m && s!=address(0) && r!=address(0)) {
                updateParticipantOnInsertTransfer_r58(r);
                updateTotalInTransferOnInsertTransfer_r34(r,n);
                updateTotalOutTransferOnInsertTransfer_r41(s,n);
                updateParticipantOnInsertTransfer_r29(s);
                return true;
              }
            }
          }
        }
      }
      return false;
  }
  function updateParticipantOnInsertRecv_transferFrom_r11(address p) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
      return true;
      return false;
  }
  function updateBalanceOfOnIncrementTotalBurn_r33(address p,int b) private    {
      int _delta = int(-b);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateUniswapV2PairOnInsertConstructor_r59() private    {
      uniswapV2Pair = UniswapV2PairTuple(address(0),true);
  }
  function updateParticipantOnInsertBurn_r16(address p) private    {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
  }
  function updateTransferOnInsertRecv_transfer_r61(address r,uint n) private   returns (bool) {
      if(r==owner.p) {
        address s = msg.sender;
        if(address(0)==uniswapV2Pair.p) {
          uint m = balanceOf[s].n;
          if(false==blacklists[r].b) {
            if(false==blacklists[s].b) {
              if(n<=m && s!=address(0) && r!=address(0)) {
                updateParticipantOnInsertTransfer_r58(r);
                updateTotalInTransferOnInsertTransfer_r34(r,n);
                updateTotalOutTransferOnInsertTransfer_r41(s,n);
                updateParticipantOnInsertTransfer_r29(s);
                return true;
              }
            }
          }
        }
      }
      return false;
  }
  function updateParticipantOnInsertTransferFrom_r19(address p) private    {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
  }
  function updateParticipantOnInsertBlacklistAction_r52(address p) private    {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
  }
  function updateParticipantOnInsertTransferFrom_r25(address p) private    {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
  }
  function updateTransferOnInsertRecv_transfer_r13(address r,uint n) private   returns (bool) {
      address p = uniswapV2Pair.p;
      address s = msg.sender;
      if(true==limited.b) {
        uint m = balanceOf[s].n;
        if(false==blacklists[r].b) {
          if(false==blacklists[s].b) {
            if(r!=address(0) && s!=p && p!=address(0) && n<=m && s!=address(0)) {
              updateParticipantOnInsertTransfer_r58(r);
              updateTotalInTransferOnInsertTransfer_r34(r,n);
              updateTotalOutTransferOnInsertTransfer_r41(s,n);
              updateParticipantOnInsertTransfer_r29(s);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateSetRuleActionOnInsertRecv_setRule_r32(bool b,address p,uint mx,uint mn) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updateUniswapV2PairOnInsertSetRuleAction_r2(p);
        updateMinHoldingAmountOnInsertSetRuleAction_r14(mn);
        updateMaxHoldingAmountOnInsertSetRuleAction_r27(mx);
        updateLimitedOnInsertSetRuleAction_r44(b);
        emit SetRuleAction(b,p,mx,mn);
        return true;
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalOutTransferFrom_r33(address p,int o2) private    {
      int _delta = int(-o2);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateParticipantOnInsertRecv_decreaseAllowance_r8(address s) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(s);
      emit Participant(s);
      return true;
      return false;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r55(address o,address r,uint n) private   returns (bool) {
      if(r==owner.p) {
        address s = msg.sender;
        if(address(0)==uniswapV2Pair.p) {
          if(false==blacklists[o].b) {
            uint m = balanceOf[o].n;
            if(false==blacklists[r].b) {
              uint k = allowance[o][s].n;
              if(n<=m && n<=k && o!=address(0) && r!=address(0)) {
                updateTotalOutTransferFromOnInsertTransferFrom_r18(o,n);
                updateSpentTotalOnInsertTransferFrom_r12(o,s,n);
                updateParticipantOnInsertTransferFrom_r19(o);
                updateTotalInTransferFromOnInsertTransferFrom_r56(r,n);
                updateParticipantOnInsertTransferFrom_r37(s);
                updateParticipantOnInsertTransferFrom_r25(r);
                return true;
              }
            }
          }
        }
      }
      return false;
  }
  function updateTotalSupplyOnInsertConstructor_r51(uint m) private    {
      uint b = allBurn.n;
      uint n = m-b;
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateTotalOutTransferFromOnInsertTransferFrom_r18(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalOutTransferFrom_r33(p,delta0);
  }
  function updateAllowanceOnIncrementDecreaseAllowanceTotal_r42(address o,address s,int d) private    {
      int _delta = int(-d);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateParticipantOnInsertTransfer_r29(address p) private    {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
  }
  function updateAllowanceOnDeleteApproveTotal_r42(address o,address s,uint a) private    {
      uint x = spentTotal[o][s].n;
      uint d = decreaseAllowanceTotal[o][s].n;
      uint i = increaseAllowanceTotal[o][s].n;
      uint n = ((a+i)-d)-x;
      if(n==allowance[o][s].n) {
        allowance[o][s] = AllowanceTuple(0,false);
      }
  }
  function updateTransferFromOnInsertRecv_transferFrom_r47(address o,address r,uint n) private   returns (bool) {
      uint mn = minHoldingAmount.n;
      address p = uniswapV2Pair.p;
      address s = msg.sender;
      uint mx = maxHoldingAmount.n;
      if(true==limited.b) {
        if(false==blacklists[r].b) {
          if(false==blacklists[o].b) {
            uint b = balanceOf[r].n;
            uint m = balanceOf[o].n;
            uint k = allowance[o][s].n;
            if(x<=mx && p!=address(0) && x>=mn && n<=m && n<=k && o!=address(0) && o==p && r!=address(0)) {
              uint x = b+n;
              updateTotalOutTransferFromOnInsertTransferFrom_r18(o,n);
              updateSpentTotalOnInsertTransferFrom_r12(o,s,n);
              updateParticipantOnInsertTransferFrom_r19(o);
              updateTotalInTransferFromOnInsertTransferFrom_r56(r,n);
              updateParticipantOnInsertTransferFrom_r37(s);
              updateParticipantOnInsertTransferFrom_r25(r);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateBlacklistActionOnInsertRecv_blacklist_r1(address p,bool b) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        updateBlacklistsOnInsertBlacklistAction_r60(p,b);
        updateParticipantOnInsertBlacklistAction_r52(p);
        updateBlacklistsOnInsertBlacklistAction_r39(p,b);
        return true;
      }
      return false;
  }
  function updateAllowanceOnIncrementIncreaseAllowanceTotal_r42(address o,address s,int i) private    {
      int _delta = int(i);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateMaxHoldingAmountOnInsertSetRuleAction_r27(uint n) private    {
      maxHoldingAmount = MaxHoldingAmountTuple(n,true);
  }
  function updateMinHoldingAmountOnInsertConstructor_r28() private    {
      minHoldingAmount = MinHoldingAmountTuple(0,true);
  }
  function updateMinHoldingAmountOnInsertSetRuleAction_r14(uint n) private    {
      minHoldingAmount = MinHoldingAmountTuple(n,true);
  }
  function updateMaxHoldingAmountOnInsertConstructor_r20() private    {
      maxHoldingAmount = MaxHoldingAmountTuple(0,true);
  }
  function updateParticipantOnInsertRecv_increaseAllowance_r45(address s) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(s);
      emit Participant(s);
      return true;
      return false;
  }
  function updateParticipantOnInsertRecv_blacklist_r35(address p) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
      return true;
      return false;
  }
  function updateLimitedOnInsertSetRuleAction_r44(bool b) private    {
      limited = LimitedTuple(b,true);
  }
  function updateBlacklistsOnInsertBlacklistAction_r39(address p,bool true) private    {
      blacklists[p] = BlacklistsTuple(true,true);
  }
  function updateLimitedOnInsertConstructor_r48() private    {
      limited = LimitedTuple(false,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateApproveTotalOnInsertApprove_r23(address o,address s,uint n) private    {
      updateAllowanceOnInsertApproveTotal_r42(o,s,n);
  }
  function updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r15(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementIncreaseAllowanceTotal_r42(o,s,delta0);
      increaseAllowanceTotal[o][s].n += n;
  }
  function updateTotalBurnOnInsertBurn_r4(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalBurn_r33(p,delta0);
  }
  function updateUniswapV2PairOnInsertSetRuleAction_r2(address p) private    {
      uniswapV2Pair = UniswapV2PairTuple(p,true);
  }
  function updateParticipantOnInsertRecv_transferFrom_r24(address p) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
      return true;
      return false;
  }
  function updateTotalInTransferFromOnInsertTransferFrom_r56(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInTransferFrom_r33(p,delta0);
  }
  function updateTotalSupplyOnInsertConstructor_r17(uint n) private    {
      totalSupply = TotalSupplyTuple(n,true);
  }
  function updateParticipantOnInsertRecv_transfer_r40(address p) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
      return true;
      return false;
  }
  function updateBlacklistsOnInsertBlacklistAction_r60(address p,bool false) private    {
      blacklists[p] = BlacklistsTuple(false,true);
  }
  function updateTransferFromOnInsertRecv_transferFrom_r30(address o,address r,uint n) private   returns (bool) {
      address p = uniswapV2Pair.p;
      address s = msg.sender;
      if(false==limited.b) {
        if(false==blacklists[o].b) {
          uint m = balanceOf[o].n;
          if(false==blacklists[r].b) {
            uint k = allowance[o][s].n;
            if(r!=address(0) && p!=address(0) && n<=m && n<=k && o!=address(0)) {
              updateTotalOutTransferFromOnInsertTransferFrom_r18(o,n);
              updateSpentTotalOnInsertTransferFrom_r12(o,s,n);
              updateParticipantOnInsertTransferFrom_r19(o);
              updateTotalInTransferFromOnInsertTransferFrom_r56(r,n);
              updateParticipantOnInsertTransferFrom_r37(s);
              updateParticipantOnInsertTransferFrom_r25(r);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalInTransfer_r33(address p,int t1) private    {
      int _delta = int(t1);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTotalInTransferOnInsertTransfer_r34(address p,uint n) private    {
      int delta0 = int(n);
      updateBalanceOfOnIncrementTotalInTransfer_r33(p,delta0);
  }
  function updateBalanceOfOnIncrementTotalInTransferFrom_r33(address p,int t2) private    {
      int _delta = int(t2);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r0(address o,address r,uint n) private   returns (bool) {
      address s = msg.sender;
      if(address(0)==uniswapV2Pair.p) {
        if(o==owner.p) {
          if(false==blacklists[o].b) {
            uint m = balanceOf[o].n;
            if(false==blacklists[r].b) {
              uint k = allowance[o][s].n;
              if(n<=m && n<=k && o!=address(0) && r!=address(0)) {
                updateTotalOutTransferFromOnInsertTransferFrom_r18(o,n);
                updateSpentTotalOnInsertTransferFrom_r12(o,s,n);
                updateParticipantOnInsertTransferFrom_r19(o);
                updateTotalInTransferFromOnInsertTransferFrom_r56(r,n);
                updateParticipantOnInsertTransferFrom_r37(s);
                updateParticipantOnInsertTransferFrom_r25(r);
                return true;
              }
            }
          }
        }
      }
      return false;
  }
  function updateAllBurnOnInsertBurn_r10(uint n) private    {
      int delta0 = int(n);
      updateTotalSupplyOnIncrementAllBurn_r51(delta0);
      allBurn.n += n;
  }
  function updateOwnerOnInsertConstructor_r21() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateApproveOnInsertRecv_approve_r57(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      if(o!=address(0) && s!=address(0)) {
        updateApproveTotalOnInsertApprove_r23(o,s,n);
        emit Approve(o,s,n);
        return true;
      }
      return false;
  }
  function updateInitialMintOnInsertConstructor_r46(uint n) private    {
      address p = owner.p;
      // Empty()
  }
  function updateBalanceOfOnIncrementTotalOutTransfer_r33(address p,int o1) private    {
      int _delta = int(-o1);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateAllowanceOnIncrementSpentTotal_r42(address o,address s,int x) private    {
      int _delta = int(-x);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateIncreaseAllowanceOnInsertRecv_increaseAllowance_r53(address s,uint n) private   returns (bool) {
      address o = msg.sender;
      if(o!=address(0) && s!=address(0)) {
        updateIncreaseAllowanceTotalOnInsertIncreaseAllowance_r15(o,s,n);
        emit IncreaseAllowance(o,s,n);
        return true;
      }
      return false;
  }
  function updateParticipantOnInsertTransferFrom_r37(address s) private    {
      updateBlacklistsOnInsertParticipant_r50(s);
      emit Participant(s);
  }
  function updateTransferOnInsertRecv_transfer_r3(address r,uint n) private   returns (bool) {
      uint mn = minHoldingAmount.n;
      address p = uniswapV2Pair.p;
      address s = msg.sender;
      uint mx = maxHoldingAmount.n;
      if(true==limited.b) {
        uint m = balanceOf[s].n;
        uint b = balanceOf[r].n;
        if(false==blacklists[r].b) {
          if(false==blacklists[s].b) {
            if(x<=mx && p!=address(0) && x>=mn && n<=m && s==p && s!=address(0) && r!=address(0)) {
              uint x = b+n;
              updateParticipantOnInsertTransfer_r58(r);
              updateTotalInTransferOnInsertTransfer_r34(r,n);
              updateTotalOutTransferOnInsertTransfer_r41(s,n);
              updateParticipantOnInsertTransfer_r29(s);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateParticipantOnInsertTransfer_r58(address p) private    {
      updateBlacklistsOnInsertParticipant_r50(p);
      emit Participant(p);
  }
  function updateDecreaseAllowanceTotalOnInsertDecreaseAllowance_r9(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementDecreaseAllowanceTotal_r42(o,s,delta0);
      decreaseAllowanceTotal[o][s].n += n;
  }
  function updateAllowanceOnInsertApproveTotal_r42(address o,address s,uint a) private    {
      ApproveTotalTuple memory toDelete = approveTotal[o][s];
      if(toDelete._valid==true) {
        updateAllowanceOnDeleteApproveTotal_r42(o,s,toDelete.n);
      }
      uint x = spentTotal[o][s].n;
      uint d = decreaseAllowanceTotal[o][s].n;
      uint i = increaseAllowanceTotal[o][s].n;
      uint n = ((a+i)-d)-x;
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateParticipantOnInsertConstructor_r6() private    {
      address s = msg.sender;
      updateBlacklistsOnInsertParticipant_r50(s);
      emit Participant(s);
  }
  function updateParticipantOnInsertRecv_approve_r22(address s) private   returns (bool) {
      updateBlacklistsOnInsertParticipant_r50(s);
      emit Participant(s);
      return true;
      return false;
  }
  function updateBalanceOfOnInsertConstructor_r49(uint n) private    {
      address s = msg.sender;
      balanceOf[s] = BalanceOfTuple(n,true);
  }
  function updateSpentTotalOnInsertTransferFrom_r12(address o,address s,uint n) private    {
      int delta0 = int(n);
      updateAllowanceOnIncrementSpentTotal_r42(o,s,delta0);
      spentTotal[o][s].n += n;
  }
  function updateBurnOnInsertRecv_burn_r31(uint n) private   returns (bool) {
      address p = msg.sender;
      uint m = balanceOf[p].n;
      if(p!=address(0) && n<=m) {
        updateAllBurnOnInsertBurn_r10(n);
        updateTotalBurnOnInsertBurn_r4(p,n);
        updateParticipantOnInsertBurn_r16(p);
        return true;
      }
      return false;
  }
}