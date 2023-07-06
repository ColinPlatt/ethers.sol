//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "lib/solady/src/utils/LibString.sol";

library ExtLibString {

    function toMinimalHexString(uint256 value) internal pure returns (string memory str) {
        str = LibString.toHexStringNoPrefix(value);

        /// @solidity memory-safe-assembly
        assembly {
            // forgefmt: disable-next-item
            let offset := eq(byte(0, mload(add(str, 0x20))), 0x30) // Check if leading zero is present.

            let strLength := add(mload(str), 2) // Compute the length.
            mstore(add(str, offset), 0x3078) // Write the "0x" prefix. Adjusting for leading zero.
            str := sub(str, sub(2, offset)) // Move the pointer.
            mstore(str, sub(strLength, offset)) // Write the length.
        }
    }

    /// @dev Returns a concatenated string of array of strings `arr`.
    /// Cheaper than `string.concat()` and does not de-align the free memory pointer.
    function concat(string[] memory arr)
        internal
        pure
        returns (string memory result)
    {
        assembly {
            let w := not(0x1f)
            result := mload(0x40)
            let totalLength := 0
            let output := result
            
            for { let i := 0 } lt(i, mload(arr)) { i := add(i, 1) } {
                let str := mload(add(arr, add(mul(i, 0x20), 0x20)))
                let strLength := mload(str)
                
                // Copy `str` one word at a time, backwards.
                for { let o := and(add(strLength, 0x20), w) } 1 {} {
                    mstore(add(output, o), mload(add(str, o)))
                    o := add(o, w) // `sub(o, 0x20)`.
                    if iszero(o) { break }
                }
                
                totalLength := add(totalLength, strLength)
                output := add(output, strLength)
            }
            
            // Zeroize the slot after the string.
            let last := add(add(result, 0x20), totalLength)
            mstore(last, 0)
            // Stores the length.
            mstore(result, totalLength)
            // Allocate memory for the length and the bytes,
            // rounded up to a multiple of 32.
            mstore(0x40, and(add(last, 0x1f), w))
        }
    }
}