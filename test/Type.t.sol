// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/types/html.sol"; 

import "src/utils/HTML.sol";

contract TypeTest is Test {

    function testTypeSetup() public {
        html memory _html;
        _html = _html.title("UDVT HTML");
        _html = _html.style("body { background-color: red; }");
        _html = _html.div_("This is a div");

        string memory result = _html.read();
        emit log_named_string("website", result);

        /* returns:
        <!DOCTYPE html>
        <html>
        <head>
            <title>UDVT HTML</title>
            <style>
            body {
                background-color: red;
            }
            </style>
        </head>
        <body>
            <div>This is a div</div>
        </body>
        </html>
        */
        vm.writeFile("test/output/typedSite.html", result);
    }

    function testLibSetup() public {
        string memory result = HTML.html(
            string.concat(
                HTML.head(
                    string.concat(
                        HTML.title("UDVT HTML"),
                        HTML.style("body { background-color: red; }")
                    )
                ),
                HTML.body(
                    HTML.div("This is a div")
                )
            )
        );
        emit log_named_string("website", result);
        vm.writeFile("test/output/libSite.html", result);
    }

    function testStringsOnlySetup() public {
        string memory result = string.concat(
            "<!DOCTYPE html><html><head>",
            "<title>UDVT HTML</title>",
            "<style>body { background-color: red; }</style>",
            "</head><body>",
            "<div>This is a div</div>",
            "</body></html>"
        );
        emit log_named_string("website", result);
        vm.writeFile("test/output/stringsSite.html", result);
    }

    

}