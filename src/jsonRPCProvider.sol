// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { LibString } from "lib/solady/src/Milady.sol";

contract jsonRPCProvider {
    using LibString for *;

    function _request(string memory method) internal pure returns (string memory) {
        return string.concat(
            'await window.ethereum.request({"method": "',
            method,
            '","params": []});'
        );
    }

    function _request(string memory method, string memory params) internal pure returns (string memory) {
        return string.concat(
            'await window.ethereum.request({"method": "',
            method,
            '","params": [',
            params,
            ']});'
        );
    }

    function _request(string memory _method, string memory _params, string memory _promise) internal pure returns (string memory) {
        return string.concat(
            'await window.ethereum.request({"method": "',
            _method,
            '","params": [',
            _params,
            ']}).then(',
            _promise,
            ');'
        );
    }

    function _request(string memory _method, string memory _params, string memory _promise, string memory _catch) internal pure returns (string memory) {
        return string.concat(
            'await window.ethereum.request({"method": "',
            _method,
            '","params": [',
            _params,
            ']}).then(',
            _promise,
            ').catch(',
            _catch,
            ');'
        );
    }

    enum subscriptionType { logs, newHeads, newPendingTransactions, syncing }

    function _subscriptionTypeToString(subscriptionType _type) internal pure returns (string memory) {
            string memory _typeString;
            if(_type == subscriptionType.logs) {
                _typeString = '"logs"';
            } else if(_type == subscriptionType.newHeads) {
                _typeString = '"newHeads"';
            } else if(_type == subscriptionType.newPendingTransactions) {
                _typeString = '"newPendingTransactions"';
            } else if(_type == subscriptionType.syncing) {
                _typeString = '"syncing"';
            }
            return _typeString;
    }

    function eth_subscribe(subscriptionType _type) public pure returns (string memory) {
        return _request('eth_subscribe', string.concat(_subscriptionTypeToString(_type), ', null'));
    }

    function eth_subscribe(subscriptionType _type, address _address) public pure returns (string memory) {
        return _request('eth_subscribe', string.concat(_subscriptionTypeToString(_type), ',', _address.toHexString()));
    }

    function eth_unsubscribe(bytes memory _subscriptionId) public pure returns (string memory) {
        return _request('eth_unsubscribe', string.concat('"', _subscriptionId.toHexString(), '"'));
    }

    function personal_sign(bytes memory _challenge, address _address) public pure returns (string memory) {
        return _request('personal_sign', string.concat('"', _challenge.toHexString(), '","', _address.toHexString(), '"'));
    }

    function eth_sendTransaction(string memory _transaction) public pure returns (string memory) {
        return _request('eth_sendTransaction', _transaction);
    }



}