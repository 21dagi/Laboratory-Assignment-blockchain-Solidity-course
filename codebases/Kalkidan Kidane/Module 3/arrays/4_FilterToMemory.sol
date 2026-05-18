// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    function filterEven(uint[] calldata numbers) external pure returns (uint[] memory) {
        uint count = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                count++;
            }
        }

        uint[] memory result = new uint[](count);
        uint idx = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                result[idx] = numbers[i];
                idx++;
            }
        }

        return result;
    }
}
