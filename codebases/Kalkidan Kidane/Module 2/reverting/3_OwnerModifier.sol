// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    address immutable owner;
    uint public configA;
    uint public configB;
    uint public configC;

    constructor() {
        owner = msg.sender;
    }

    function setA(uint _configA) public onlyOwner {
        configA = _configA;
    }

    function setB(uint _configB) public onlyOwner {
        configB = _configB;
    }

    function setC(uint _configC) public onlyOwner {
        configC = _configC;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}
