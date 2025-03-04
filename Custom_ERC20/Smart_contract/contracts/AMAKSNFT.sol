// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract AMAKSNFT is ERC721, Ownable {

    uint256 tokenCount;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) Ownable(msg.sender) {
        mint(msg.sender);
    }

    function mint(address _to) public onlyOwner returns (bool) {
        uint256 tokenId = tokenCount + 1;

        _safeMint(_to, tokenId);

        tokenCount = tokenId;

        return true;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory uri = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "AMAKSNFT',
                        name(),
                        " #",
                        Strings.toString(tokenId),
                        '",',
                        '"description": "Amaks_Token",',
                        '"image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(SVGImage())),
                        '"}'
                    )
                ) 
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", uri));
    }

    function SVGImage() internal pure returns (string memory) {
        
        return
        '<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">'
        '<rect width="200" height="200" fill="#f0f0f0"/>'
        '<circle cx="100" cy="100" r="50" fill="#3498db" stroke="#2980b9" stroke-width="2"/>'
        '<polygon points="100,60 85,90 115,90" fill="#e74c3c"/>'
        '<rect x="80" y="110" width="40" height="20" rx="5" fill="#2ecc71"/>'
        '<text x="60" y="170" font-family="Arial" font-size="16" fill="#333">Amaks_Token</text>'
        '</svg>';
}

}

