pragma solidity ^0.8.0;

library FunctionCoder {
    function encode(function () pure returns (string memory) fn) internal pure returns (bytes32 ret) {
        assembly {
            ret := fn
        }
    }

    function encode(function (string memory) pure returns (string memory) fn) internal pure returns (bytes32 ret) {
        assembly {
            ret := fn
        }
    }

    function encode(function (string memory, string memory) pure returns (string memory) fn)
        internal
        pure
        returns (bytes32 ret)
    {
        assembly {
            ret := fn
        }
    }

    function encode(function (string memory, string memory, string memory) pure returns (string memory) fn)
        internal
        pure
        returns (bytes32 ret)
    {
        assembly {
            ret := fn
        }
    }

    function decode(bytes32 fn) internal pure returns (string memory) {
        function () pure returns (string memory) func;
        assembly {
            func := fn
        }
        return func();
    }

    function decode(bytes32 fn, string memory input) internal pure returns (string memory) {
        function (string memory) pure returns (string memory) func;
        assembly {
            func := fn
        }
        return func(input);
    }

    function decode(bytes32 fn, string memory input1, string memory input2) internal pure returns (string memory) {
        function (string memory, string memory) pure returns (string memory) func;
        assembly {
            func := fn
        }
        return func(input1, input2);
    }

    function decode(bytes32 fn, string memory input1, string memory input2, string memory input3)
        internal
        pure
        returns (string memory)
    {
        function (string memory, string memory, string memory) pure returns (string memory) func;
        assembly {
            func := fn
        }
        return func(input1, input2, input3);
    }
}
