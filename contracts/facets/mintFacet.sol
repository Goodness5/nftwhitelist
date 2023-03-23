// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

import { libNftMint} from "../libraries/libNftMint.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NftMintFacet {
    function addProof(bytes32 _proof) external {
        libNftMint.addProofs(_proof);
    }

    function passmerkleroot(bytes32 _root) external {
        libNftMint.passmerkleroot(_root);
    }
     function mint() external {
        libNftMint.mint();
    }

     function balanceOf(address _owner) external view {
        libNftMint.balanceOf(_owner);
    }


     function _transfer(address from, address to, uint256 tokenId) external {
        libNftMint._transfer(from, to, tokenId);
    }

}
