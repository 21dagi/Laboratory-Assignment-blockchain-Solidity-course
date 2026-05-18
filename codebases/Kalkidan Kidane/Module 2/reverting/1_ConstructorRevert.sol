// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function withdraw() public {
        require(msg.sender == owner);
        (bool s, ) = owner.call{ value: address(this).balance }("");
        require(s);
    }
}
