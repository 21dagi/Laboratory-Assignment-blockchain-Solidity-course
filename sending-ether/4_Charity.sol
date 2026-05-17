// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contract {
    address public owner;
    address public charity;

    // Modified constructor to accept charity address
    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    // Receive ether sent directly to the contract
    receive() external payable {}

    // Send tipped ether to the owner
    function tip() public payable {
        (bool success, ) = owner.call{value: msg.value}("");
        require(success);
    }

    // Donate all remaining contract funds to charity
    function donate() public {
        uint balance = address(this).balance;

        (bool success, ) = charity.call{value: balance}("");
        require(success);
    }
}