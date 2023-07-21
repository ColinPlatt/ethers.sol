// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {LibString} from "lib/solady/src/Milady.sol";

struct css {
    string elements;
}

/* CSS STRUCTURE OPERATIONS */
function readCSS(css memory _css) pure returns (string memory css_) {
    return _css.elements;
}

function addCSSElement(css memory _css, string memory _identifier, string memory _element) pure {
    _css.elements = string.concat(_css.elements, _identifier, " { ", _element, " }");
}

using {readCSS, addCSSElement} for css global;
