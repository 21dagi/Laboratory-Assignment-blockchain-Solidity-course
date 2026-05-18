// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StackClub {
    address[] public members;

    constructor() {
        members.push(msg.sender);
    }

    function addMember(address member) external onlyMember {
        members.push(member);
    }

    function removeLastMember() external onlyMember {
        members.pop();
    }

    function isMember(address addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == addr) {
                return true;
            }
        }
        return false;
    }

    modifier onlyMember {
        require(isMember(msg.sender));
        _;
    }
}
