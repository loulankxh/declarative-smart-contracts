contract Voting {
  struct QuorumSizeTuple {
    uint q;
    bool _valid;
  }
  struct IsVoterTuple {
    bool b;
    bool _valid;
  }
  struct WinningProposalTuple {
    uint proposal;
    bool _valid;
  }
  struct VotedTuple {
    bool b;
    bool _valid;
  }
  struct VotesTuple {
    uint c;
    bool _valid;
  }
  struct WinsTuple {
    bool b;
    bool _valid;
  }
  struct HasWinnerTuple {
    bool b;
    bool _valid;
  }
  QuorumSizeTuple quorumSize;
  mapping(address=>IsVoterTuple) isVoter;
  WinningProposalTuple winningProposal;
  mapping(address=>VotedTuple) voted;
  HasWinnerTuple hasWinner;
  mapping(uint=>VotesTuple) votes;
  mapping(uint=>WinsTuple) wins;
  event Vote(address p,uint proposal);
  function getWinningProposal() public view  returns (uint) {
      uint proposal = winningProposal.proposal;
      return proposal;
  }
  function getHasWinner() public view  returns (bool) {
      bool b = hasWinner.b;
      return b;
  }
  function getIsVoter(address v) public view  returns (bool) {
      bool b = isVoter[v].b;
      return b;
  }
  function getVoted(address p) public view  returns (bool) {
      bool b = voted[p].b;
      return b;
  }
  function getWins(uint proposal) public view  returns (bool) {
      bool b = wins[proposal].b;
      return b;
  }
  function getVotes(uint proposal) public view  returns (uint) {
      uint c = votes[proposal].c;
      return c;
  }
  function vote(uint proposal) public    {
      bool r5 = updateVoteOnInsertRecv_vote_r5(proposal);
      if(r5==false) {
        revert("Rule condition failed");
      }
  }
  function updateHasWinnerOnInsertWins_r1(uint _proposal0,bool b) private    {
      WinsTuple memory toDelete = wins[_proposal0];
      if(toDelete._valid==true) {
        updateHasWinnerOnDeleteWins_r1(_proposal0,toDelete.b);
      }
      if(b==true) {
        hasWinner = HasWinnerTuple(true,true);
      }
  }
  function updateVotedOnInsertVote_r3(address v,uint _proposal1) private    {
      voted[v] = VotedTuple(true,true);
  }
  function updateWinningProposalOnInsertWins_r4(uint p,bool b) private    {
      WinsTuple memory toDelete = wins[p];
      if(toDelete._valid==true) {
        updateWinningProposalOnDeleteWins_r4(p,toDelete.b);
      }
      if(b==true) {
        winningProposal = WinningProposalTuple(p,true);
      }
  }
  function updateWinningProposalOnDeleteWins_r4(uint p,bool b) private    {
      if(b==true) {
        winningProposal = WinningProposalTuple(0,false);
      }
  }
  function updateVotesOnInsertVote_r0(address _p0,uint p) private    {
      int delta0 = int(1);
      updateWinsOnIncrementVotes_r2(p,delta0);
      votes[p].c += 1;
  }
  function updateWinsOnIncrementVotes_r2(uint p,int c) private    {
      int _delta = int(c);
      uint newValue = updateuintByint(votes[p].c,_delta);
      updateWinsOnInsertVotes_r2(p,newValue);
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateWinsOnDeleteVotes_r2(uint p,uint c) private    {
      uint q = quorumSize.q;
      if(c>=q) {
        updateHasWinnerOnDeleteWins_r1(p,bool(true));
        updateWinningProposalOnDeleteWins_r4(p,bool(true));
        if(true==wins[p].b) {
          wins[p] = WinsTuple(false,false);
        }
      }
  }
  function updateWinsOnInsertVotes_r2(uint p,uint c) private    {
      VotesTuple memory toDelete = votes[p];
      if(toDelete._valid==true) {
        updateWinsOnDeleteVotes_r2(p,toDelete.c);
      }
      uint q = quorumSize.q;
      if(c>=q) {
        updateHasWinnerOnInsertWins_r1(p,bool(true));
        updateWinningProposalOnInsertWins_r4(p,bool(true));
        wins[p] = WinsTuple(true,true);
      }
  }
  function updateVoteOnInsertRecv_vote_r5(uint p) private   returns (bool) {
      if(false==hasWinner.b) {
        address v = msg.sender;
        if(true==isVoter[v].b) {
          if(false==voted[v].b) {
            updateVotedOnInsertVote_r3(v,p);
            updateVotesOnInsertVote_r0(v,p);
            emit Vote(v,p);
            return true;
          }
        }
      }
      return false;
  }
  function updateHasWinnerOnDeleteWins_r1(uint _proposal0,bool b) private    {
      if(b==true) {
        hasWinner = HasWinnerTuple(false,false);
      }
  }
}