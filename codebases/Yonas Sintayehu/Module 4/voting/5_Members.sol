// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
    enum VoteStatus { Absent, Yes, No }

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;
    mapping(uint => mapping(address => VoteStatus)) public votes;
    mapping(address => bool) public members;

    event ProposalCreated(uint);
    event VoteCast(uint, address);

    constructor(address[] memory _members) {
        members[msg.sender] = true;
        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
    }

    function newProposal(address target, bytes calldata data) external onlyMember {
        proposals.push(Proposal(target, data, 0, 0));
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external onlyMember {
        VoteStatus prev = votes[proposalId][msg.sender];

        if (prev == VoteStatus.Yes) {
            proposals[proposalId].yesCount--;
        } else if (prev == VoteStatus.No) {
            proposals[proposalId].noCount--;
        }

        if (support) {
            proposals[proposalId].yesCount++;
            votes[proposalId][msg.sender] = VoteStatus.Yes;
        } else {
            proposals[proposalId].noCount++;
            votes[proposalId][msg.sender] = VoteStatus.No;
        }

        emit VoteCast(proposalId, msg.sender);
    }

    modifier onlyMember {
        require(members[msg.sender]);
        _;
    }
}
