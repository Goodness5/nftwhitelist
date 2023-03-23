// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

import { NftData } from "./libNftData.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";



library libNftMint {


    function addProofs(bytes32 _proof)  internal{
        NftData storage ds = storageSlot();
        bytes32[] storage arr =ds.proofs;
        arr.push(_proof);

    }

    function mint() internal{
        NftData storage ds = storageSlot();
        address nft = ds.NftAddress;
        require(checkValidity(), "not approved");
        IERC721(nft)._safeMint();

    }

 function checkValidity() public view returns (bool){
        NftData storage ds = storageSlot();
        bytes32 root = ds.merkleRoot;
       bytes32[] memory _merkleProof = ds.proofs;
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_merkleProof, root, leaf), "Incorrect proof");
        return true;
    }

 function storageSlot() internal pure returns(NftData storage ds) {

        assembly {
            ds.slot := 0
        }
      }
}
