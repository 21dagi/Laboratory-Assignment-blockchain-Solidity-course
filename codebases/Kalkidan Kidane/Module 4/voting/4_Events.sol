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

    event ProposalCreated(uint);
    event VoteCast(uint, address);

    function newProposal(address target, bytes calldata data) external {
        proposals.push(Proposal(target, data, 0, 0));
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
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
}
