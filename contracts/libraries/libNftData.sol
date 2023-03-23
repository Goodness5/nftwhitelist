// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;






    struct NftData {
        bytes32 merkleRoot;
        bytes32[] proofs;
        mapping(address => bool) minted;
        address NftAddress;

    }