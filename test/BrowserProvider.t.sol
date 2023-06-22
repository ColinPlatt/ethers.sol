// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/BrowserProvider.sol"; 

contract BrowserProviderTest is Test {

    BrowserProvider public provider;

    function setUp() public {
        provider = new BrowserProvider();
    }

    function testwallet_addEthereumChain() public {
        BrowserProvider.NativeCurrency memory nativeCurrency = BrowserProvider.NativeCurrency("Ethereum", "ETH", 18);
        string memory rpcUrls = '["https://mainnet.infura.io/v3/"]';
        string memory blockExplorerUrls = '["https://etherscan.io/"]';
        string memory result = provider.wallet_addEthereumChain('0x1', "Ethereum", nativeCurrency, rpcUrls, blockExplorerUrls);
        assertEq(result, 
            string.concat(
                '"method":"wallet_addEthereumChain",',
                '"params":[{',
                    '"chainId":"0x1",',
                    '"chainName":"Ethereum",',
                    '"nativeCurrency":{',
                        '"name":"Ethereum",',
                        '"symbol":"ETH",',
                        '"decimals":"18"',
                    '},',
                    '"rpcUrls":["https://mainnet.infura.io/v3/"],',
                    '"blockExplorerUrls":["https://etherscan.io/"]',
                '}]'
            ));
    }

    

}