contract Mkr {
  struct StoppedTuple {
    bool b;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  StoppedTuple stopped;
  OwnerTuple owner;
  event SetOwner(address guy);
  event PullAction(address src,address dst,address spender,uint wad);
  event StartAction(bool b);
  event MoveAction(address src,address dst,address spender,uint wad);
  event Approve(address owner,address spender,uint wad);
  event Mint(address guy,uint wad);
  event Burn(address guy,uint wad);
  event Transfer(address src,address dst,uint wad);
  event TransferFrom(address src,address dst,address spender,uint wad);
  event PushAction(address src,address dst,uint wad);
  event StopAction(bool b);
  constructor(uint symbol) public {
    updateOwnerOnInsertConstructor_r9();
    updateStoppedOnInsertConstructor_r3();
  }
  function transfer(address dst,uint wad) public    {
      bool r7 = updateTransferOnInsertRecv_transfer_r7(dst,wad);
      if(r7==false) {
        revert("Rule condition failed");
      }
  }
  function transferFrom(address src,address dst,uint wad) public    {
      bool r14 = updateTransferFromOnInsertRecv_transferFrom_r14(src,dst,wad);
      if(r14==false) {
        revert("Rule condition failed");
      }
  }
  function burn(address guy,uint wad) public    {
      bool r4 = updateBurnOnInsertRecv_burn_r4(guy,wad);
      if(r4==false) {
        revert("Rule condition failed");
      }
  }
  function approve(address spender,uint wad) public    {
      bool r11 = updateApproveOnInsertRecv_approve_r11(spender,wad);
      if(r11==false) {
        revert("Rule condition failed");
      }
  }
  function stop() public    {
      bool r6 = updateStopActionOnInsertRecv_stop_r6();
      if(r6==false) {
        revert("Rule condition failed");
      }
  }
  function pull(address src,uint wad) public    {
      bool r15 = updatePullActionOnInsertRecv_pull_r15(src,wad);
      if(r15==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address guy,uint wad) public    {
      bool r13 = updateMintOnInsertRecv_mint_r13(guy,wad);
      if(r13==false) {
        revert("Rule condition failed");
      }
  }
  function push(address dst,uint wad) public    {
      bool r2 = updatePushActionOnInsertRecv_push_r2(dst,wad);
      if(r2==false) {
        revert("Rule condition failed");
      }
  }
  function move(address src,address dst,uint wad) public    {
      bool r16 = updateMoveActionOnInsertRecv_move_r16(src,dst,wad);
      if(r16==false) {
        revert("Rule condition failed");
      }
  }
  function setOwner(address guy) public    {
      bool r5 = updateSetOwnerOnInsertRecv_setOwner_r5(guy);
      if(r5==false) {
        revert("Rule condition failed");
      }
  }
  function start() public    {
      bool r10 = updateStartActionOnInsertRecv_start_r10();
      if(r10==false) {
        revert("Rule condition failed");
      }
  }
  function updateStoppedOnInsertStartAction_r1(bool b) private    {
      stopped = StoppedTuple(b,true);
  }
  function updateMoveActionOnInsertRecv_move_r16(address o,address r,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address s = msg.sender;
        uint k = allowance[o][s].n;
        if(o!=address(0) && r!=address(0) && k>=n) {
          emit MoveAction(o,r,s,n);
          return true;
        }
      }
      return false;
  }
  function updatePushActionOnInsertRecv_push_r2(address r,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address s = msg.sender;
        if(s!=address(0) && r!=address(0)) {
          emit PushAction(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateSetOwnerOnInsertRecv_setOwner_r5(address g) private   returns (bool) {
      address s = owner.p;
      if(s==msg.sender) {
        if(g!=address(0)) {
          updateOwnerOnInsertSetOwner_r12(g);
          emit SetOwner(g);
          return true;
        }
      }
      return false;
  }
  function updateStoppedOnInsertStopAction_r8(bool b) private    {
      stopped = StoppedTuple(b,true);
  }
  function updateTransferOnInsertRecv_transfer_r7(address r,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address s = msg.sender;
        if(s!=address(0) && r!=address(0)) {
          emit Transfer(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateMintOnInsertRecv_mint_r13(address g,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address s = owner.p;
        if(s==msg.sender) {
          if(g!=address(0)) {
            emit Mint(g,n);
            return true;
          }
        }
      }
      return false;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r14(address o,address r,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address s = msg.sender;
        uint k = allowance[o][s].n;
        if(o!=address(0) && r!=address(0) && k>=n) {
          emit TransferFrom(o,r,s,n);
          return true;
        }
      }
      return false;
  }
  function updateOwnerOnInsertSetOwner_r12(address g) private    {
      owner = OwnerTuple(g,true);
  }
  function updateStopActionOnInsertRecv_stop_r6() private   returns (bool) {
      if(false==stopped.b) {
        address s = owner.p;
        if(s==msg.sender) {
          updateStoppedOnInsertStopAction_r8(bool(true));
          emit StopAction(true);
          return true;
        }
      }
      return false;
  }
  function updateStartActionOnInsertRecv_start_r10() private   returns (bool) {
      if(true==stopped.b) {
        address s = owner.p;
        if(s==msg.sender) {
          updateStoppedOnInsertStartAction_r1(bool(false));
          emit StartAction(false);
          return true;
        }
      }
      return false;
  }
  function updatePullActionOnInsertRecv_pull_r15(address o,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address s = msg.sender;
        uint k = allowance[o][s].n;
        if(o!=address(0) && k>=n) {
          emit PullAction(o,s,s,n);
          return true;
        }
      }
      return false;
  }
  function updateAllowanceOnInsertApprove_r0(address o,address s,uint n) private    {
      allowance[o][s] = AllowanceTuple(n,true);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateBurnOnInsertRecv_burn_r4(address g,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address s = owner.p;
        if(s==msg.sender) {
          if(g!=address(0)) {
            emit Burn(g,n);
            return true;
          }
        }
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r9() private    {
      address s = msg.sender;
      owner = OwnerTuple(s,true);
  }
  function updateStoppedOnInsertConstructor_r3() private    {
      stopped = StoppedTuple(false,true);
  }
  function updateApproveOnInsertRecv_approve_r11(address s,uint n) private   returns (bool) {
      if(false==stopped.b) {
        address o = msg.sender;
        if(o!=address(0) && s!=address(0)) {
          updateAllowanceOnInsertApprove_r0(o,s,n);
          emit Approve(o,s,n);
          return true;
        }
      }
      return false;
  }
}