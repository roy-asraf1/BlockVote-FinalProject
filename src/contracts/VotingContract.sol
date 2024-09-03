// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {
    struct Candidate {
        string name;
        uint voteCount;
    }

    struct Voter {
        bool authorized;
        bool voted;
        uint vote;
    }

    address public owner;
    string public electionName;

    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint public totalVotes;

    modifier ownerOnly() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }

    constructor(string memory _name) {
        owner = msg.sender;
        electionName = _name;
    }

    function addCandidate(string memory _name) public ownerOnly {
        candidates.push(Candidate(_name, 0));
    }

    function getNumCandidates() public view returns (uint) {
        return candidates.length;
    }

    function authorize(address _person) public ownerOnly {
        voters[_person].authorized = true;
    }

    function vote(uint _voteIndex) public {
        require(!voters[msg.sender].voted, "You have already voted");
        require(voters[msg.sender].authorized, "You are not authorized to vote");
        require(_voteIndex < candidates.length, "Invalid candidate index");

        voters[msg.sender].vote = _voteIndex;
        voters[msg.sender].voted = true;

        candidates[_voteIndex].voteCount += 1;
        totalVotes += 1;
    }

    function endElection() public ownerOnly view returns (string memory winnerName) {
        uint winningVoteCount = 0;
        uint winningIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningIndex = i;
            }
        }

        winnerName = candidates[winningIndex].name;
    }
}
