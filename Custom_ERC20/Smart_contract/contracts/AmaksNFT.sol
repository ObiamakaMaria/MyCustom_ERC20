// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract OnChainNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;


    constructor() ERC721("BezNFT", "bez") Ownable(msg.sender) {}

    function mintNFT() public onlyOwner {
        _tokenIdCounter++;
        uint256 newItemId = _tokenIdCounter;

        
        string memory svgImage = generateSVG();
        string memory json = string(
            abi.encodePacked(
                '{"name": "On-Chain NFT #', 
                uint2str(newItemId),
                '", "description": "This is an on-chain NFT", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(svgImage)), '"}'
            )
        );

        string memory finalTokenURI = string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(json))));

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenURI);
    }

    function generateSVG() internal pure returns (string memory) {
        return "<svg xmlns='http://www.w3.org/2000/svg' width='500' height='500'>"
               "<rect width='100%' height='100%' fill='blue'/>"
               "<text x='50%' y='50%' font-size='24' text-anchor='middle' fill='white'>On-Chain NFT</text>"
               "</svg>";
    }

    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) return "0";
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            bstr[k] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
}
