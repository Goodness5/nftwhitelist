// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

import { NftData} from "./libNftData.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

library libNftMint {
    function addProofs(bytes32 _proof) internal {
        NftData storage ds = storageSlot();
        bytes32[] storage arr = ds.proofs;
        arr.push(_proof);
    }
    function passmerkleroot(bytes32 _root) internal {
        NftData storage ds = storageSlot();
        ds.merkleRoot = _root;
    }

    function mint() internal {
        NftData storage ds = storageSlot();
        uint256 _tokenId = ds.tokenId;
        require(checkValidity(), "not approved");
        _mint(msg.sender, _tokenId);
        ds.tokenId += 1;
    }

    function checkValidity() public view returns (bool) {
        NftData storage ds = storageSlot();
        bytes32 root = ds.merkleRoot;
        bytes32[] memory proof =  ds.proof[msg.sender];
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(proof, root, leaf), "Incorrect proof");
        return true;
    }

    function storageSlot() internal pure returns (NftData storage ds) {
        assembly {
            ds.slot := 0
        }
    }

    function _mint(address _to, uint256 _tokenId) internal {
         NftData storage ds = storageSlot();
          require(_to != address(0), "mint to the zero address");
        require(ds._owners[_tokenId]== address(0), " token already minted");
        ds._owners[_tokenId] = msg.sender;
       
    }
    function balanceOf(address owner) internal view returns (uint256) {
        NftData storage ds = storageSlot();
        require(owner != address(0), "ERC721: address zero is not a valid owner");
        return ds._balances[owner];
    }

      function ownerOf(uint256 tokenId) internal view returns (address) {
        NftData storage ds = storageSlot();
        address owner = ds._owners[tokenId];
        require(owner != address(0), "unminted Token");
        return owner;
    }

        function _transfer(address from, address to, uint256 tokenId) internal  {
            NftData storage ds = storageSlot();
        require(ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");
        require(to != address(0), "ERC721: transfer to the zero address");
        require(ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");

        // Clear approvals from the previous owner
        delete ds._tokenApprovals[tokenId];
        ds._owners[tokenId] = to;
    }

     function _approve(address to, uint256 tokenId) internal  {
          NftData storage ds = storageSlot();
        ds._tokenApprovals[tokenId] = to;
    }
     function getApproved(uint256 tokenId) internal view  returns (address) {
         NftData storage ds = storageSlot();

        return ds._tokenApprovals[tokenId];
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view  returns (bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender);
    }
    function transferFrom(address from, address to, uint256 tokenId) public {
                  NftData storage ds = storageSlot();
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: caller is not token owner or approved");
        _transfer(from, to, tokenId);
    }

}
