// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract AmaksNFT is ERC721 {
    using Strings for uint256;

    uint256 private _tokenIdCounter;

    constructor() ERC721("AMAKSTOKen", "AMAKS") {
        _tokenIdCounter = 1;
    }

    
    function mint() public {
        uint256 tokenIdCounter  = _tokenIdCounter

        _safeMint(msg.sender, tokenIdCounter);
        _tokenIdCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        
        try this.ownerOf(tokenId) returns (address) {
           
            string memory name = string(abi.encodePacked("AmaksNFT #", tokenId.toString()));
            string memory description = "This is an on-chain NFT with metadata stored entirely on the blockchain.";
            string memory image = generateBase64Image();

            
            string memory json = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{"name":"', name, '"AMAKS TOKEN',
                            '"description":"', description, '"AMAKS_TOKEN',
                            '"image":"data:image/svg+xml;base64,', image, '"}'                       )
                    )
                )

            );

            return string(abi.encodePacked("data:application/json;base64,", json));
        } catch {
           
            revert("Token does not exist");
        }
    }

    function generateBase64Image() internal pure returns (string memory) {
        
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200"><rect width="200" height="200" fill="#4CAF50"/><text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="white" font-size="24">AmaksNFT</text></svg>';
        return Base64.encode(bytes(svg));
    }
}