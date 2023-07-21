//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {Base64} from "lib/solady/src/utils/Base64.sol";

// JSON utilities for base64 encoded ERC721 JSON metadata scheme
library json {
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// @dev JSON requires that double quotes be escaped or JSONs will not build correctly
    /// string.concat also requires an escape, use \\" or the constant DOUBLE_QUOTES to represent " in JSON
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    string constant DOUBLE_QUOTES = '\\"';

    function formattedMetadataHTML(string memory name, string memory description, string memory html)
        internal
        pure
        returns (string memory)
    {
        return string.concat(
            "data:application/json;base64,",
            Base64.encode(
                bytes(string.concat("{", _prop("name", name), _prop("description", description), _htmlPage(html), "}"))
            )
        );
    }

    function formattedMetadata(string memory name, string memory description, string memory svg)
        internal
        pure
        returns (string memory)
    {
        return string.concat(
            "data:application/json;base64,",
            Base64.encode(
                bytes(string.concat("{", _prop("name", name), _prop("description", description), _xmlImage(svg), "}"))
            )
        );
    }

    function _htmlPage(string memory _html) internal pure returns (string memory) {
        return _prop("animation_url", string.concat("data:text/html;base64,", Base64.encode(bytes(_html))), true);
    }

    function _xmlImage(string memory _svgImg) internal pure returns (string memory) {
        return _prop("image_data", string.concat("data:image/svg+xml;base64,", Base64.encode(bytes(_svgImg))), true);
    }

    function _prop(string memory _key, string memory _val) internal pure returns (string memory) {
        return string.concat('"', _key, '": ', '"', _val, '", ');
    }

    function _prop(string memory _key, string memory _val, bool last) internal pure returns (string memory) {
        if (last) {
            return string.concat('"', _key, '": ', '"', _val, '"');
        } else {
            return string.concat('"', _key, '": ', '"', _val, '", ');
        }
    }

    function _object(string memory _key, string memory _val) internal pure returns (string memory) {
        return string.concat('"', _key, '": ', "{", _val, "}");
    }
}
