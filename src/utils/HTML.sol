//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
import './Utils.sol';

// Core HTML utility library which helps us construct
// onchain HTMLs with a simple, web-like API.
library HTML {

    /* MAIN ELEMENTS */
    function html(string memory _children)
        internal
        pure
        returns (string memory)
    {
        return string.concat(
            '<!DOCTYPE html>',
            el('html', _children)
        );
    }

    function head(string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('head', _children);
    }

    function title(string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('title', _children);
    }

    function style(string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('style', _children);
    }

    function body(string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('body', _children);
    }

    function div(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('div', _props, _children);
    }

    function textarea(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('textarea', _props, _children);
    }

    function img(string memory _src, string memory _props)
        internal
        pure
        returns (string memory)
    {
        return
            el(
                'img',
                string.concat(prop('src', _src), ' ', _props)
            );
    }

    function link(string memory _props)
        internal
        pure
        returns (string memory)
    {
        return elProp('link', _props);
    }

    function script(string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('script', _children);
    }

    function script(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('script', _props, _children);
    }

    function scriptExternal(string memory _src)
        internal
        pure
        returns (string memory)
    {
        return string.concat(
                '<script ',
                prop('src', _src),
                '></script>'
            );
    }

    function a(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('a', _props, _children);
    }

    function p(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('p', _props, _children);
    }

    function span(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('span', _props, _children);
    }

    function button(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('button', _props, _children);
    }

    function h1(string memory _props, string memory _children)
        internal
        pure
        returns (string memory)
    {
        return el('h1', _props, _children);
    }
    
    /* CSS */
    function cssSelector(string memory _selector, string memory _decl)
        internal
        pure
        returns (string memory)
    {
        return
            string.concat(
                _selector,
                '{',
                _decl,
                '}'
            );
    }

    /* COMMON */
    // A generic element, can be used to construct any HTML element
    function el(
        string memory _tag,
        string memory _props,
        string memory _children
    ) internal pure returns (string memory) {
        return
            string.concat(
                '<',
                _tag,
                ' ',
                _props,
                '>',
                _children,
                '</',
                _tag,
                '>'
            );
    }

    // A generic element, can be used to construct any HTML element without props
    function el(
        string memory _tag,
        string memory _children
    ) internal pure returns (string memory) {
        return
            string.concat(
                '<',
                _tag,
                '>',
                _children,
                '</',
                _tag,
                '>'
            );
    }

    // A generic element, can be used to construct any HTML element without children
    function elProp(
        string memory _tag,
        string memory _prop
    ) internal pure returns (string memory) {
        return
            string.concat(
                '<',
                _tag,
                ' ',
                _prop,
                '/>'
            );
    }

    // an HTML attribute
    function prop(string memory _key, string memory _val)
        internal
        pure
        returns (string memory)
    {
        return string.concat(_key, '=', '"', _val, '" ');
    }

    function cssDecl(string memory _prop, string memory _val)
        internal
        pure
        returns (string memory)
    {
        return string.concat(_prop, ': ', _val, ';');
    }

}