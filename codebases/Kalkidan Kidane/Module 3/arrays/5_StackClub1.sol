// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StackClub {
    address[] public members;

    function addMember(address member) external {
        members.push(member);
    }

    function isMember(address addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == addr) {
                return true;
            }
        }
        return false;
    }
}
