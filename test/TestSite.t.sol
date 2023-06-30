// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/BrowserProvider.sol"; 

import "src/utils/HTML.sol";

contract SiteTest is Test {

    BrowserProvider public provider;
    TestWebsite public website;

    function setUp() public {
        provider = new BrowserProvider();
        website = new TestWebsite(provider);
    }

    function testSiteOutput() public {
        string memory result = website.returnSite();
        emit log_named_string("website", result);
        vm.writeFile("test/output/renderedSite.html", result);
    }




}

contract TestWebsite {
    using HTML for *;

    BrowserProvider public provider;

    constructor(BrowserProvider _provider) {
        provider = _provider;
    }

    function _getScript() internal view returns (string memory) {
        return HTML.script(string.concat(
            'document.addEventListener("DOMContentLoaded", function() {var connectButton = document.getElementById("connectButton");connectButton.addEventListener("click", async function() {'
            'const provider = await connectWallet();',
            'if (provider) {await ',
            provider.ethereum_request(provider.eth_accounts()),
            '.then(async function (accounts) { if (accounts.length === 0) { ',
            'ethereum.enable().then(function (accounts) { console.log(accounts); }).catch(console.error); } else { console.log(accounts); } }).catch(console.error);}',
            '});});',
            provider.connectWallet()
        ));
    }

    function _getBody() internal view returns (string memory) {
        return HTML.body(string.concat(
            HTML.button('id="connectButton"', "Connect to Wallet"),
            _getScript()
        ));
    }

    function returnSite() public view returns (string memory) {
        return HTML.html(string.concat(
            HTML.head(string.concat(
                HTML.title("TestSite")
            )),
            _getBody()
        ));
    }

    function testHTML() public {

        string memory result = returnSite();

        vm.writeFile("test/output/renderedSite.html", result);
    }
}