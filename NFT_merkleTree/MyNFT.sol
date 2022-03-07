// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

interface IMerkleTree {
    function hash(address sender, address receiver, uint256 tokenId, string memory tokenURI) 
    external 
    pure 
    returns (bytes32);
    
    function merkleRoot(bytes32[] memory hashes) external returns (bytes32);
}

contract MyNFT is ERC721URIStorage{
    uint256 public countToken;
    bytes32 public merkleroot;
    // bytes32[] public merkleleaves = new bytes32[](4);
    bytes32[] public merkleleaves;

    constructor()  ERC721("SimpleNFT", "SIM"){
        countToken = 0;
    }

    function mintToken(address _merkle, address _to, string memory tokenURI) public returns (uint256){
        
        uint256 tokenId = countToken;
        bytes32 current_hash;
        _safeMint(_to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        current_hash = IMerkleTree(_merkle).hash(msg.sender, _to, tokenId, tokenURI);
        // merkleleaves[tokenId] = current_hash;
        merkleleaves.push(current_hash);
        merkleroot = IMerkleTree(_merkle).merkleRoot(merkleleaves);
        countToken += 1;
        return tokenId;
    }

}