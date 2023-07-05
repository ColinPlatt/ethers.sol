# Ethers.sol: Ethereum JSON-RPC and Ethereum Provider Enabled Contracts

## Overview
This repository contains Solidity smart contracts designed to generate JavaScript code to interact with an Ethereum blockchain through the JSON-RPC and Ethereum Provider (Metamask) API. The JavaScript code will be served to a client's browser as a fully functional HTML website. The contracts allow for various interactions, such as connecting to a wallet, requesting permissions, switching chains, and executing various Ethereum operations.

## Contracts
Contracts are available as importable libraries, as well as contracts. 

This repo provides additional utility libraries that give developers basic helpers for creating HTML, onchain ERC721 JSONs which can be served via ```tokenURI```

```ml
├─ libJsonRPCProvider / jsonRPCProvider - the base contract that provides basic JSON-RPC request formation functionality.
├─ libBrowserProvider / BrowserProvider - an extension of libJonRPCProvider that includes methods for connecting to an Ethereum provider in a web browser, interacting with the Ethereum network, and manipulating wallet connections.
utils
├─ Utils - library with basic functions for creating CSS, HTML elements, and string tools, as well as a toMinimalHexString` extension to `solady/LibString.sol` which returns a HexString without any leading zeroes, conforming to the Ethereum JSON-RPC specs.
├─ JSON - library with functions for base64 encoding and returning fully formed, compliant ERC721 JSONs, which work with most major NFT platforms that support onchain served HTML. 
├─ HTML - library for building onchain HTML sites which can be served via eth_call to return formed HTML pages.
```

## Installation

To install with [**Foundry**](https://github.com/gakonst/foundry):

```sh
forge install
```

This template repo is shipped with a Python Flask server which allows developers to monitor and serve files via `localhost`, instructions on running this are provided in a separate README in the python folder. 


## Key Features
- Boilerplate Wallet connection handling
- Ethereum chain switching
- Ethereum permissions requests
- Asset watching (ERC20)
- Encryption and decryption of messages
- Public key fetching
- Ethereum account fetching
- Ethereum typed data signing

## Future Improvements
We plan to extend these contracts further to handle more diverse Ethereum interactions such as:

- ERC1155 and ERC5169 support
- Wider wallet connection support

And more!

## Getting Started
Here's a basic guide on how to deploy and use these contracts:

Add instructions about how to deploy and use your contracts

## Safety

This is **experimental software** and is provided on an "as is" and "as available" basis.

We **do not give any warranties** and **will not be liable for any loss** incurred through any use of this codebase.

While Solady has been heavily tested, there may be parts that may exhibit unexpected emergent behavior when used with other code, or may break in future Solidity versions.  

Please always include your own thorough tests when using Solady to make sure it works correctly with your code.  

## Contribution
Contributions are welcome! Please feel free to submit a pull request.

## Acknowledgements

This repository is inspired by or directly modified from many sources, primarily:

- [Solmate](https://github.com/vectorized/solady)
- [hot-chain-svg](https://github.com/w1nt3r-eth/hot-chain-svg)


[license-shield]: https://img.shields.io/badge/License-MIT-green.svg
[license-url]: https://github.com/ColinPlatt/ethers.sol/blob/main/LICENSE.txt