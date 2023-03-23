// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;






    struct NftData {
        bytes32 merkleRoot;
        bytes32[] proofs;
        mapping(address => bool) minted;
        address NftAddress;
        uint256 tokenId;
        string  _name;
        string  _symbol;
        mapping(uint256 => address)  _owners;
        mapping(address => uint256)  _balances;
        mapping(uint256 => address)  _tokenApprovals;
        mapping(address => mapping(address => bool))  _operatorApprovals;
    }