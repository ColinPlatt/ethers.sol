// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { LibString } from "lib/solady/src/Milady.sol";

struct Transaction {
    string object;
}

struct Object {
    address from;
    address to;
    uint value;
    bytes data;
    uint nonce;
    uint gasPrice;
    uint gasLimit;
    uint chainId;
}

function transactionObject(
    Object memory _object
) pure returns (Transaction memory) {
    return Transaction(string.concat(
        '{"from": "',
        LibString.toHexString(_object.from),
        '","to": "',
        LibString.toHexString(_object.to),
        '","value": "',
        LibString.toHexString(_object.value),
        '","data": "',
        LibString.toHexString(_object.data),
        '","nonce": "',
        LibString.toHexString(_object.nonce),
        '","gasPrice": "',
        LibString.toHexString(_object.gasPrice),
        '","gasLimit": "',
        LibString.toHexString(_object.gasLimit),
        '","chainId": "',
        LibString.toHexString(_object.chainId),
        '"}'
    ));
}

struct ObjectTags{
    string[] tags;
    string[] args;
}

error unbalancedTags();

function transactionObjectByTag(ObjectTags memory _object) pure returns (Transaction memory) {
    if(_object.tags.length != _object.args.length) revert unbalancedTags();
    
    string memory transactionBuilder ="{";

    unchecked {
        for(uint i = 0; i < _object.tags.length; i++){
            transactionBuilder = string.concat(
                transactionBuilder,
                '"',
                _object.tags[i],
                '": "',
                _object.args[i],
                i == _object.tags.length - 1 ? '"' : '",'
            );
        }
    }

    return Transaction(transactionBuilder);
}

function read(Transaction memory _transaction) pure returns (string memory) {
    return _transaction.object;
}

using {transactionObject} for Object global;
using {transactionObjectByTag} for ObjectTags global;
using {read} for Transaction global;