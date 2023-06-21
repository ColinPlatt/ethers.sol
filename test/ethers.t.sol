// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ethers.sol"; 

contract ethersTest is Test {

    ethers_sol public ethers;

    function setUp() public {
        ethers = new ethers_sol();
    }

    function test_eth_accounts() public {
        assertEq(ethers.eth_accounts(), 'await window.ethereum.request({"method": "eth_accounts","params": []});');
    }

}