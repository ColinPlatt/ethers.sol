// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { LibString } from "lib/solady/src/Milady.sol";

struct html {
    string head;
    string body;
}

/* HTML STRUCTURE OPERATIONS */
function read(
    html memory _html
) pure returns (string memory) {
    return string.concat(
        "<!DOCTYPE html><html><head>",
        _html.head,
        "</head><body>",
        _html.body,
        "</body></html>"
    );
}

function appendHead(
    html memory _html,
    string memory _head
) pure returns (html memory) {
    return html(
        string.concat(_html.head, _head),
        _html.body
    );
}

function prependHead(
    html memory _html,
    string memory _head
) pure returns (html memory) {
    return html(
        string.concat(_head, _html.head),
        _html.body
    );
}

function appendBody(
    html memory _html,
    string memory _body
) pure returns (html memory) {
    return html(
        _html.head,
        string.concat(_html.body, _body)
    );
}

function prependBody(
    html memory _html,
    string memory _body
) pure returns (html memory) {
    return html(
        _html.head,
        string.concat(_body, _html.body)
    );
}

/* MAIN ELEMENTS */
function title(
    html memory _html,
    string memory _title
) pure returns (html memory) {
    return _html.appendHead(el('title', _title));
}

function style(
    html memory _html,
    string memory _style
) pure returns (html memory) {
    return _html.appendHead(el('style', _style));
}

function div(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('div', _props, _children));
}

function div_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('div', _children));
}

function textarea(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('textarea', _props, _children));
}

function link(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendHead(el('link', _props, _children));
}

function link_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendHead(el('link', _children));
}

function a(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('a', _props, _children));
}

function a_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('a', _children));
}

function p(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('p', _props, _children));
}

function p_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('p', _children));
}

function span(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('span', _props, _children));
}

function span_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('span', _children));
}

function button(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('button', _props, _children));
}

function button_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('button', _children));
}

function h1(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('h1', _props, _children));
}

function h1_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('h1', _children));
}

function h2(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('h2', _props, _children));
}

function h2_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('h2', _children));
}

function hN(
    html memory _html,
    uint _n,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el(string.concat('h',LibString.toString(_n)), _props, _children));
}

function hN_(
    html memory _html,
    uint _n,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el(string.concat('h',LibString.toString(_n)), _children));
}

function script(
    html memory _html,
    string memory _props,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('script', _props, _children));
}

function script_(
    html memory _html,
    string memory _children
) pure returns (html memory) {
    return _html.appendBody(el('script', _children));
}


/* COMMON */
// A generic element, can be used to construct any HTML element
function el(
    string memory _tag,
    string memory _props,
    string memory _children
) pure returns (string memory) {
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
) pure returns (string memory) {
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
) pure returns (string memory) {
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
    pure
    returns (string memory)
{
    return string.concat(_key, '=', '"', _val, '" ');
}

using {
    read, 
    appendHead, 
    prependHead, 
    appendBody, 
    prependBody
} for html global;

using {
    title,
    style,
    div,
    div_,
    textarea,
    link,
    link_,
    a,
    a_,
    p,
    p_,
    span,
    span_,
    button,
    button_,
    h1,
    h1_,
    h2,
    h2_,
    hN,
    hN_,
    script,
    script_
} for html global;

