// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Receive ether sent directly to the contract
    receive() external payable {}

    // Send tipped ether to the owner
    function tip() public payable {
        (bool success, ) = owner.call{value: msg.value}("");
        require(success);
    }
}