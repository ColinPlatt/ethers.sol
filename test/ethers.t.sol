// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/BrowserProvider.sol"; 

contract BrowserProviderTest is Test {

    BrowserProvider public ethers;

    function setUp() public {
        ethers = new BrowserProvider();
    }

    function test_eth_accounts() public {
        assertEq(ethers.eth_accounts(), 'await window.ethereum.request({"method": "eth_accounts","params": []});');
    }

}