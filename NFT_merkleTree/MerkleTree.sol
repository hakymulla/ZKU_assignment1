// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MerkleTree {   

    bytes32[] hashed;

    function merkleRoot(bytes32[] memory hashes) external returns (bytes32){
        uint n = hashes.length;
        uint offset = 0;

        hashed = hashes;

        while (n>1) {
            for (uint i = 0; i < n - 1; i += 2) {
                hashed.push(
                    keccak256(
                        abi.encodePacked(hashes[offset + i], hashes[offset + i + 1])
                    )
                );
            }
            offset += n;
            n = n / 2;
        }
        return hashed[hashed.length - 1];
    }

    function hash(address sender, address receiver, uint256 tokenId, string memory tokenURI) external pure returns (bytes32){
        return keccak256(abi.encodePacked(sender, receiver, tokenId, tokenURI));
    }
}