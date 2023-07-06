// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { LibString } from "lib/solady/src/Milady.sol"; 

import {ExtLibString} from "src/utils/ExtLibString.sol";

contract concatTest is Test {




    function testControl() public {

        string[] memory input = new string[](3); 
        input[0] = "tesaflksdjlaskjdpoair";
        input[1] = "salkdjsdopiuqewfewdklvjsd;ifogqh23j;eiasoicyh3";
        input[2] = "sdlkajsdoiupweofujhwdnvsd;lk.fuj;32okda,s.ncv";

        string memory result = string.concat(input[0], input[1], input[2]);
        emit log_string(result);
    }

    function testSolady() public {

        string[] memory input = new string[](3); 
        input[0] = "tesaflksdjlaskjdpoair";
        input[1] = "salkdjsdopiuqewfewdklvjsd;ifogqh23j;eiasoicyh3";
        input[2] = "sdlkajsdoiupweofujhwdnvsd;lk.fuj;32okda,s.ncv";

        string memory result = LibString.concat(input[0], LibString.concat(input[1],input[2]));
        emit log_string(result);

    }

    function testSoladyNonOpt() public {

        string[] memory input = new string[](3); 
        input[0] = "tesaflksdjlaskjdpoair";
        input[1] = "salkdjsdopiuqewfewdklvjsd;ifogqh23j;eiasoicyh3";
        input[2] = "sdlkajsdoiupweofujhwdnvsd;lk.fuj;32okda,s.ncv";

        string memory result = concat(input[0], concat(input[1],input[2]));
        emit log_string(result);

    }

    function testSoladyOpt() public {

        string[] memory input = new string[](3); 
        input[0] = "tesaflksdjlaskjdpoair";
        input[1] = "salkdjsdopiuqewfewdklvjsd;ifogqh23j;eiasoicyh3";
        input[2] = "sdlkajsdoiupweofujhwdnvsd;lk.fuj;32okda,s.ncv";

        string memory result = concatCp(input[0], concatCp(input[1],input[2]));
        emit log_string(result);

    }

    function testSoladyChange() public {
            
            string[] memory input = new string[](3); 
            input[0] = "tesaflksdjlaskjdpoair";
            input[1] = "salkdjsdopiuqewfewdklvjsd;ifogqh23j;eiasoicyh3";
            input[2] = "sdlkajsdoiupweofujhwdnvsd;lk.fuj;32okda,s.ncv";
    
            string memory resultOpt = concatCp(input[0], concatCp(input[1],input[2]));
            string memory resultNonOpt = LibString.concat(input[0], LibString.concat(input[1],input[2]));
            assertEq(resultOpt, resultNonOpt);
    
    }

    function testArr() public {
        string[] memory input = new string[](3); 
        input[0] = "tesaflksdjlaskjdpoair";
        input[1] = "salkdjsdopiuqewfewdklvjsd;ifogqh23j;eiasoicyh3";
        input[2] = "sdlkajsdoiupweofujhwdnvsd;lk.fuj;32okda,s.ncv";

        string memory result = concat(input);
        emit log_string(result);
    }


    function testEquals() public {
        string[] memory input = new string[](3); 
        input[0] = "tesaflksdjlaskjdpoair";
        input[1] = "salkdjsdopiuqewfewdklvjsd;ifogqh23j;eiasoicyh3";
        input[2] = "sdlkajsdoiupweofujhwdnvsd;lk.fuj;32okda,s.ncv";

        string memory resultControl = string.concat(input[0], input[1], input[2]);
        string memory resultSolady = LibString.concat(input[0], LibString.concat(input[1],input[2]));
        string memory resultArr = concat(input);

        assertEq(resultArr, resultControl);
        assertEq(resultSolady, resultControl);


        
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


    /// @dev Returns a concatenated string of `a` and `b`.
    /// Cheaper than `string.concat()` and does not de-align the free memory pointer.
    function concat(string memory a, string memory b)
        internal
        pure
        returns (string memory result)
    {
        /// @solidity memory-safe-assembly
        assembly {
            let w := not(0x1f)
            result := mload(0x40)
            let aLength := mload(a)
            // Copy `a` one word at a time, backwards.
            for { let o := and(add(mload(a), 0x20), w) } 1 {} {
                mstore(add(result, o), mload(add(a, o)))
                o := add(o, w) // `sub(o, 0x20)`.
                if iszero(o) { break }
            }
            let bLength := mload(b)
            let output := add(result, mload(a))
            // Copy `b` one word at a time, backwards.
            for { let o := and(add(bLength, 0x20), w) } 1 {} {
                mstore(add(output, o), mload(add(b, o)))
                o := add(o, w) // `sub(o, 0x20)`.
                if iszero(o) { break }
            }
            let totalLength := add(aLength, bLength)
            let last := add(add(result, 0x20), totalLength)
            // Zeroize the slot after the string.
            mstore(last, 0)
            // Stores the length.
            mstore(result, totalLength)
            // Allocate memory for the length and the bytes,
            // rounded up to a multiple of 32.
            mstore(0x40, and(add(last, 0x1f), w))
        }
    }

    /// @dev Returns a concatenated string of `a` and `b`.
    /// Cheaper than `string.concat()` and does not de-align the free memory pointer.
    function concatCp(string memory a, string memory b)
        internal
        pure
        returns (string memory result)
    {
        /// @solidity memory-safe-assembly
        assembly {
            let w := not(0x1f)
            result := mload(0x40)
            let aLength := mload(a)
            // Copy `a` one word at a time, backwards.
            for { let o := and(add(aLength, 0x20), w) } 1 {} {
                mstore(add(result, o), mload(add(a, o)))
                o := add(o, w) // `sub(o, 0x20)`.
                if iszero(o) { break }
            }
            let bLength := mload(b)
            let output := add(result, aLength)
            // Copy `b` one word at a time, backwards.
            for { let o := and(add(bLength, 0x20), w) } 1 {} {
                mstore(add(output, o), mload(add(b, o)))
                o := add(o, w) // `sub(o, 0x20)`.
                if iszero(o) { break }
            }
            let totalLength := add(aLength, bLength)
            let last := add(add(result, 0x20), totalLength)
            // Zeroize the slot after the string.
            mstore(last, 0)
            // Stores the length.
            mstore(result, totalLength)
            // Allocate memory for the length and the bytes,
            // rounded up to a multiple of 32.
            mstore(0x40, and(add(last, 0x1f), w))
        }
    }


}