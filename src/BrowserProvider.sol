// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { jsonRPCProvider, LibString } from "src/jsonRPCProvider.sol";

contract BrowserProvider is jsonRPCProvider {
    using LibString for *;

    struct NativeCurrency {
        string name;
        string symbol;
        uint256 decimals;
    }

    struct Key {
        string key;
        string value;
    }

    // simple function that checks if the window.ethereum object is available, and if there are multiple providers, it will return the MetaMask provider
    function connectWallet() public pure returns (string memory) {
        return 'const connectWallet=async()=>{if(void 0!==window.ethereum){let e=window.ethereum;if(window.ethereum.providers&&window.ethereum.providers.length){let t=window.ethereum.providers.map(async t=>{t.isMetaMask&&(e=t)});await Promise.all(t)}return e}};';
    }
    
    function ethereum_request(string memory _request) public pure returns (string memory) {
        return string.concat(
            'ethereum.request({',
            _request,
            '})'
        );
    }


    function _nativeCurrency(NativeCurrency memory nativeCurrency) internal pure returns (string memory) {
        return string.concat(
            '{"name":"',
            nativeCurrency.name,
            '","symbol":"',
            nativeCurrency.symbol,
            '","decimals":"',
            nativeCurrency.decimals.toString(),
            '"}'
        );
    }

    function _newKey(Key memory _Key) internal pure returns (string memory) {
        return string.concat('"', _Key.key, '":"', _Key.value, '"');
    }

    function wallet_addEthereumChain(string memory _chainId, string memory _chainName, NativeCurrency memory nativeCurrency, string memory _rpcUrls, string memory _blockExplorerUrls) public pure returns (string memory) {
        return _request('wallet_addEthereumChain', string.concat(
            '{"chainId":"',
            _chainId,
            '","chainName":"',
            _chainName,
            '","nativeCurrency":',
            _nativeCurrency(nativeCurrency),
            ',"rpcUrls":',
            _rpcUrls,
            ',"blockExplorerUrls":',
            _blockExplorerUrls,
            '}'
        ));
    }

    function wallet_switchEthereumChain(string memory _chainId) public pure returns (string memory) {
        return _request('wallet_switchEthereumChain', string.concat(
            '{"chainId":"',
            _chainId,
            '"}'
        ));
    }

    function wallet_requestPermissions() public pure returns (string memory) {
        return _request('wallet_requestPermissions', string.concat(
            '{"eth_accounts":{}}'
        ));
    }

    function wallet_requestPermissions(Key[] memory _Keys) public pure returns (string memory) {
        string memory _KeysString;
        unchecked {
            for (uint i = 0; i < _Keys.length; i++) {
                _KeysString = string.concat(_KeysString, _newKey(_Keys[i]));
                if (i < _Keys.length - 1) {
                    _KeysString = string.concat(_KeysString, ',');
                }
            }
        }
        return _request('wallet_requestPermissions', string.concat(
            '{"eth_accounts":{',
            _KeysString,
            '}}'
        ));
    }

    function wallet_getPermissions() public pure returns (string memory) {
        return _request('wallet_getPermissions');
    }

    function wallet_registerOnboarding() public pure returns (string memory) {
        return _request('wallet_registerOnboarding');
    }

    function wallet_watchAsset(address _address, string memory _symbol, string memory _decimals, string memory _image) public pure returns (string memory) {
        return _request('wallet_watchAsset', string.concat(
            '{"type":"ERC20","options":{"address":"',
            _address.toHexString(),
            '","symbol":"',
            _symbol,
            '","decimals":"',
            _decimals,
            '","image":"',
            _image,
            '"}}'
        ));
    }

    function eth_decrypt(string memory _encryptedMessage, address _address) public pure returns (string memory) {
        return _request('eth_decrypt', string.concat(
            '"',
            _encryptedMessage,
            '","',
            _address.toHexString(),
            '"'
        ));
    }

    function eth_getEncryptionPublicKey(address _address) public pure returns (string memory) {
        return _request('eth_getEncryptionPublicKey', string.concat('"', _address.toHexString(),'"'));
    }

    function eth_accounts() public pure returns (string memory) {
        return _request('eth_accounts');
    }

    function eth_signTypedData_v4(address _address, string memory _typedData) public pure returns (string memory) {
        return _request('eth_signTypedData_v4', string.concat(
            '"',
            _address.toHexString(),
            '",',
            _typedData
        ));
    }
    

}