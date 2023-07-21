// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {LibString} from "lib/solady/src/Milady.sol";

struct fn {
    string _function;
}

/* FUNCTION STRUCTURE OPERATIONS */
function readFn(fn memory _fn) pure returns (string memory) {
    return _fn._function;
}

function appendFn(fn memory _fn, string memory _op) pure {
    _fn._function = LibString.concat(_fn._function, _op);
}

function prependFn(fn memory _fn, string memory _op) pure {
    _fn._function = LibString.concat(_op, _fn._function);
}

function initializeNamedFn(fn memory _fn, string memory _name) pure {
    _fn._function = string.concat("function ", _name, "()");
}

function initializeNamedArgsFn(fn memory _fn, string memory _name, string memory _args) pure {
    _fn._function = string.concat("function ", _name, "(", _args, ")");
}

function initializeFn(fn memory _fn) pure {
    _fn._function = "function()";
}

function initializeArgsFn(fn memory _fn, string memory _args) pure {
    _fn._function = string.concat("function(", _args, ")");
}

function asyncFn(fn memory _fn) pure {
    _fn.prependFn("async ");
}

function bodyFn(fn memory _fn, string memory _body) pure {
    _fn.appendFn(string.concat("{", _body, "}"));
}

function openBodyFn(fn memory _fn) pure {
    _fn.appendFn("{");
}

function closeBodyFn(fn memory _fn) pure {
    _fn.appendFn("}");
}

using {
    readFn,
    appendFn,
    prependFn,
    initializeNamedFn,
    initializeNamedArgsFn,
    initializeFn,
    initializeArgsFn,
    asyncFn,
    bodyFn,
    openBodyFn,
    closeBodyFn
} for fn global;

enum ArrowFn {
    Const,
    Var,
    Let
}

function getArrowFnType(ArrowFn _type) pure returns (string memory) {
    if (_type == ArrowFn.Const) {
        return "const ";
    } else if (_type == ArrowFn.Var) {
        return "var ";
    } else {
        return "let ";
    }
}

struct arrowFn {
    string _function;
}

/* ARROW FUNCTION STRUCTURE OPERATIONS */
function readArrowFn(arrowFn memory _arrowFn) pure returns (string memory) {
    return _arrowFn._function;
}

function appendArrowFn(arrowFn memory _arrowFn, string memory _op) pure {
    _arrowFn._function = LibString.concat(_arrowFn._function, _op);
}

function prependArrowFn(arrowFn memory _arrowFn, string memory _op) pure {
    _arrowFn._function = LibString.concat(_op, _arrowFn._function);
}

function initializeNamedArrowFn(arrowFn memory _arrowFn, ArrowFn _type, string memory _name) pure {
    _arrowFn._function = string.concat(getArrowFnType(_type), _name, " = () => ");
}

function initializeNamedArgsArrowFn(arrowFn memory _arrowFn, ArrowFn _type, string memory _name, string memory _args)
    pure
{
    _arrowFn._function = string.concat(getArrowFnType(_type), _name, " = (", _args, ") => ");
}

function initializeArrowFn(arrowFn memory _arrowFn) pure {
    _arrowFn._function = "() => ";
}

function initializeArgsArrowFn(arrowFn memory _arrowFn, string memory _args) pure {
    _arrowFn._function = string.concat("(", _args, ") => ");
}

function asyncArrowFn(arrowFn memory _arrowFn) pure {
    _arrowFn.prependArrowFn("async ");
}

function initializeNamedAsyncArrowFn(arrowFn memory _arrowFn, ArrowFn _type, string memory _name) pure {
    _arrowFn._function = string.concat(getArrowFnType(_type), _name, " = async () => ");
}

function initializeNamedAsyncArgsArrowFn(
    arrowFn memory _arrowFn,
    ArrowFn _type,
    string memory _name,
    string memory _args
) pure {
    _arrowFn._function = string.concat(getArrowFnType(_type), _name, " = async (", _args, ") => ");
}

function bodyArrowFn(arrowFn memory _arrowFn, string memory _body) pure {
    _arrowFn.appendArrowFn(string.concat("{", _body, "};"));
}

function openBodyArrowFn(arrowFn memory _arrowFn) pure {
    _arrowFn.appendArrowFn("{");
}

function closeBodyArrowFn(arrowFn memory _arrowFn) pure {
    _arrowFn.appendArrowFn("};");
}

using {
    readArrowFn,
    appendArrowFn,
    prependArrowFn,
    initializeNamedArrowFn,
    initializeNamedArgsArrowFn,
    initializeArrowFn,
    initializeArgsArrowFn,
    asyncArrowFn,
    initializeNamedAsyncArrowFn,
    initializeNamedAsyncArgsArrowFn,
    bodyArrowFn,
    openBodyArrowFn,
    closeBodyArrowFn
} for arrowFn global;
