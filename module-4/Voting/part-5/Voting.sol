// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;
    }

    Proposal[] public proposals;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

    mapping(address => bool) public members;

    constructor(address[] memory _members) {
        members[msg.sender] = true;

        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
    }

    function newProposal(address target, bytes calldata data) external {
        require(members[msg.sender], "Not a member");

        proposals.push(Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0,
            executed: false
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
        require(members[msg.sender], "Not a member");

        Proposal storage proposal = proposals[proposalId];

        if (hasVoted[proposalId][msg.sender]) {
            bool previous = voteChoice[proposalId][msg.sender];

            if (previous) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        hasVoted[proposalId][msg.sender] = true;
        voteChoice[proposalId][msg.sender] = support;

        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
        }

        emit VoteCast(proposalId, msg.sender);

        // EXECUTION LOGIC
        if (!proposal.executed && proposal.yesCount >= 10) {
            proposal.executed = true;

            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
        }
    }
}