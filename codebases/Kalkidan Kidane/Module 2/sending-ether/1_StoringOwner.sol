// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contract {
    // Public state variable
    address public owner;

    // Constructor runs once during deployment
    constructor() {
        owner = msg.sender;
    }
}