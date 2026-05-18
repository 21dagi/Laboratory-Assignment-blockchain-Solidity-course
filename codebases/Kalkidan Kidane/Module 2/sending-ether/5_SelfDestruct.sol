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

    // Self destruct and send remaining funds to charity
    function donate() public {
        selfdestruct(payable(charity));
    }
}