// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/console.sol";

contract Contract {
    function winningNumber(string calldata message) external view returns (uint) {
        console.log(message);
        return 794;
    }
}
