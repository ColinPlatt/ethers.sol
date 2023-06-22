// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { LibString } from "lib/solady/src/Milady.sol";

import { Transaction } from "src/Transaction.sol";

contract jsonRPCProvider {
    using LibString for *;

    function _request(string memory method) public pure returns (string memory) {
        return string.concat(
            '"method":"',
            method,
            '","params":[]'
        );
    }

    function _request(string memory method, string memory params) public pure returns (string memory) {
        return string.concat(
            '"method":"',
            method,
            '","params":[',
            params,
            ']'
        );
    }

    function jsonRPCRequest(string memory _request) public pure returns (string memory) {
        return string.concat(
            '{jsonrpc: "2.0",',
            _request,
            ', id: 1}'
        );
    }

    function fetch_request(string memory _rpcUrl, string memory _request) public pure returns (string memory) {
        return string.concat(
            'fetch("',
            _rpcUrl,
            '", {method: "POST", headers: {"Content-Type": "application/json"0}}, body: ',
            jsonRPCRequest(_request),
            ')'
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

    function eth_sendTransaction(Transaction memory _transaction) public pure returns (string memory) {
        return _request('eth_sendTransaction', _transaction.read());
    }

    //eth_getBlockByHash
    function eth_getBlockByHash(bytes32 _blockHash, bool _hydratedTransactions) public pure returns (string memory) {
        return _request('eth_getBlockByHash', string.concat('"', uint256(_blockHash).toHexString(), '",', _hydratedTransactions ? 'true' : 'false'));
    }

    //eth_getBlockByNumber
    function eth_getBlockByNumber(uint256 _blockNumber, bool _hydratedTransactions) public pure returns (string memory) {
        return _request('eth_getBlockByNumber', string.concat('"', _blockNumber.toHexString(), '",', _hydratedTransactions ? 'true' : 'false'));
    }
    //@todo by block tag

    //eth_getBlockTransactionCountByHash
    function eth_getBlockTransactionCountByHash(bytes32 _blockHash) public pure returns (string memory) {
        return _request('eth_getBlockTransactionCountByHash', string.concat('"', uint256(_blockHash).toHexString(), '"'));
    }

    //eth_getBlockTransactionCountByNumber
    function eth_getBlockTransactionCountByNumber(uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_getBlockTransactionCountByNumber', string.concat('"', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_getUncleByBlockHash
    function eth_getUncleByBlockHash(bytes32 _blockHash, uint256 _uncleIndex) public pure returns (string memory) {
        return _request('eth_getUncleByBlockHash', string.concat('"', uint256(_blockHash).toHexString(), '","', _uncleIndex.toHexString(), '"'));
    }

    //eth_getUncleByBlockNumber
    function eth_getUncleByBlockNumber(uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_getUncleByBlockNumber', string.concat('"', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_chainId
    function eth_chainId() public pure returns (string memory) {
        return _request('eth_chainId');
    }

    //eth_syncing
    function eth_syncing() public pure returns (string memory) {
        return _request('eth_syncing');
    }

    //eth_coinbase
    function eth_coinbase() public pure returns (string memory) {
        return _request('eth_coinbase');
    }

    //eth_blockNumber
    function eth_blockNumber() public pure returns (string memory) {
        return _request('eth_blockNumber');
    }

    //eth_call
    function eth_call(Transaction memory _transaction, uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_call', string.concat(_transaction.read(), ',"', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_estimateGas
    function eth_estimateGas(Transaction memory _transaction, uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_estimateGas', string.concat(_transaction.read(), ',"', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_gasPrice
    function eth_gasPrice() public pure returns (string memory) {
        return _request('eth_gasPrice');
    }

    //eth_MaxPriorityFeePerGas
    function eth_MaxPriorityFeePerGas() public pure returns (string memory) {
        return _request('eth_MaxPriorityFeePerGas');
    }

    //eth_feeHistory
    function eth_feeHistory(uint256 _blockCount, uint256 _newestBlock, uint256[] memory _rewardPercentiles) public pure returns (string memory) {
        string memory _rewardPercentilesString = '[';

        unchecked {
            for(uint256 i = 0; i < _rewardPercentiles.length; i++) {
                _rewardPercentilesString = string.concat(_rewardPercentilesString, _rewardPercentiles[i].toString());
                if(i < _rewardPercentiles.length - 1) {
                    _rewardPercentilesString = string.concat(_rewardPercentilesString, ',');
                }
            }
            _rewardPercentilesString = string.concat(_rewardPercentilesString, ']');
        }
        
        return _request('eth_feeHistory', string.concat('[', _blockCount.toHexString(), ',', _newestBlock.toHexString(), ',', _rewardPercentilesString, ']'));
    }

    //eth_newFilter
    function eth_newFilter(bytes32 _fromBlock, bytes32 _toBlock, address _address) public pure returns (string memory) {
        return _request('eth_newFilter', string.concat('{"fromBlock":"', uint256(_fromBlock).toHexString(), '","toBlock":"', uint256(_toBlock).toHexString(), '","address":"', _address.toHexString(), '"}'));
    }
    //@todo array of addresses

    //eth_newBlockFilter
    function eth_newBlockFilter() public pure returns (string memory) {
        return _request('eth_newBlockFilter');
    }

    //eth_newPendingTransactionFilter
    function eth_newPendingTransactionFilter() public pure returns (string memory) {
        return _request('eth_newPendingTransactionFilter');
    }

    //eth_uninstallFilter
    function eth_uninstallFilter(bytes memory _filterId) public pure returns (string memory) {
        return _request('eth_uninstallFilter', string.concat('"', _filterId.toHexString(), '"'));
    }

    //eth_getFilterChanges
    function eth_getFilterChanges(bytes memory _filterId) public pure returns (string memory) {
        return _request('eth_getFilterChanges', string.concat('"', _filterId.toHexString(), '"'));
    }

    //eth_getFilterLogs
    function eth_getFilterLogs(bytes memory _filterId) public pure returns (string memory) {
        return _request('eth_getFilterLogs', string.concat('"', _filterId.toHexString(), '"'));
    }

    //eth_getLogs
    function eth_getLogs(bytes32 _fromBlock, bytes32 _toBlock, address _address) public pure returns (string memory) {
        return _request('eth_getLogs', string.concat('{"fromBlock":"', uint256(_fromBlock).toHexString(), '","toBlock":"', uint256(_toBlock).toHexString(), '","address":"', _address.toHexString(), '"}'));
    }

    //eth_mining
    function eth_mining() public pure returns (string memory) {
        return _request('eth_mining');
    }

    //eth_hashrate
    function eth_hashrate() public pure returns (string memory) {
        return _request('eth_hashrate');
    }

    //eth_getWork
    function eth_getWork() public pure returns (string memory) {
        return _request('eth_getWork');
    }

    //eth_submitWork
    function eth_submitWork(bytes8 _nonce, bytes32 _powHash, bytes32 _mixDigest) public pure returns (string memory) {
        return _request('eth_submitWork', string.concat('"', abi.encodePacked(_nonce).toHexString(), '","', uint256(_powHash).toHexString(), '","', uint256(_mixDigest).toHexString(), '"'));
    }

    //eth_submitHashrate
    function eth_submitHashrate(bytes32 _hashrate, bytes32 _id) public pure returns (string memory) {
        return _request('eth_submitHashrate', string.concat('"', uint256(_hashrate).toHexString(), '","', uint256(_id).toHexString(), '"'));
    }

    //eth_getBalance
    function eth_getBalance(address _address, uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_getBalance', string.concat('"', _address.toHexString(), '","', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_getStorageAt
    function eth_getStorageAt(address _address, uint256 _position, uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_getStorageAt', string.concat('"', _address.toHexString(), '","', _position.toHexString(), '","', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_getTransactionCount
    function eth_getTransactionCount(address _address, uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_getTransactionCount', string.concat('"', _address.toHexString(), '","', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_getCode
    function eth_getCode(address _address, uint256 _blockNumber) public pure returns (string memory) {
        return _request('eth_getCode', string.concat('"', _address.toHexString(), '","', _blockNumber.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_getProof
    function eth_getProof(address _address, uint256[] memory _storageKeys, uint256 _blockNumber) public pure returns (string memory) {
        string memory _storageKeysString = '[';

        unchecked {
            for(uint256 i = 0; i < _storageKeys.length; i++) {
                _storageKeysString = string.concat(_storageKeysString, _storageKeys[i].toString());
                if(i < _storageKeys.length - 1) {
                    _storageKeysString = string.concat(_storageKeysString, ',');
                }
            }
            _storageKeysString = string.concat(_storageKeysString, ']');
        }
        
        return _request('eth_getProof', string.concat('{"address":"', _address.toHexString(), '","storageKeys":', _storageKeysString, ',"blockNumber":"', _blockNumber.toHexString(), '"}'));
    }
    //@todo by block tag

    //eth_sendRawTransaction
    function eth_sendRawTransaction(bytes memory _data) public pure returns (string memory) {
        return _request('eth_sendRawTransaction', string.concat('"', _data.toHexString(), '"'));
    }

    //eth_getTransactionByHash
    function eth_getTransactionByHash(bytes32 _hash) public pure returns (string memory) {
        return _request('eth_getTransactionByHash', string.concat('"', uint256(_hash).toHexString(), '"'));
    }

    //eth_getTransactionByBlockHashAndIndex
    function eth_getTransactionByBlockHashAndIndex(bytes32 _blockHash, uint256 _index) public pure returns (string memory) {
        return _request('eth_getTransactionByBlockHashAndIndex', string.concat('"', uint256(_blockHash).toHexString(), '","', _index.toHexString(), '"'));
    }

    //eth_getTransactionByBlockNumberAndIndex
    function eth_getTransactionByBlockNumberAndIndex(uint256 _blockNumber, uint256 _index) public pure returns (string memory) {
        return _request('eth_getTransactionByBlockNumberAndIndex', string.concat('"', _blockNumber.toHexString(), '","', _index.toHexString(), '"'));
    }
    //@todo by block tag

    //eth_getTransactionReceipt
    function eth_getTransactionReceipt(bytes32 _hash) public pure returns (string memory) {
        return _request('eth_getTransactionReceipt', string.concat('"', uint256(_hash).toHexString(), '"'));
    }



}