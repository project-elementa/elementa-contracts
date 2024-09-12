// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import {modifiersFacet} from "../shared/utils/modifiersFacet.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {ElementaItem, EquipmentType, ElementaNFT} from "../shared/storage/structs/AppStorage.sol";

contract nftFacet is modifiersFacet {
    function nft_getUri(uint _tokenId) external view returns (string memory) {
        return _getMetadata(_tokenId);
    }

    function _getMetadata(uint _tokenId) internal view returns (string memory) {
        // ElementaNFT memory nft = s.elementaNFTs[_tokenId];
        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name": "ElementaNFT #',
                Strings.toString(_tokenId),
                '",',
                '"description": "Test Elementa dNFT",',
                '"image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(_generateSVG(_tokenId))),
                '"}'
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    function _generateSVG(uint _tokenId) public view returns (string memory) {
        bytes memory outline = s.elementaItems[EquipmentType.Outline][4].svgUri;
        bytes memory background = s
        .elementaItems[EquipmentType.Outline][4].svgUri;
        return
            string(
                abi.encodePacked(
                    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 250">',
                    "<defs>",
                    '<linearGradient id="outline" x1="0%" y1="0%" x2="100%" y2="100%">',
                    outline,
                    "</linearGradient>",
                    '<linearGradient id="background" x1="0%" y1="0%" x2="0%" y2="100%">',
                    background,
                    "</linearGradient>",
                    "</defs>",
                    '<rect width="100%" height="100%" fill="url(#background)" stroke="url(#outline)" stroke-width="7"/>',
                    // character
                    // ...here

                    '<image x="50%" y="50%" width="50%" height="50%" href="https://i.imgur.com/W718ova.png" transform="translate(-65, -80)" />',
                    // '<image x="50%" y="50%" width="50%" height="50%" href="https://static.vecteezy.com/system/resources/previews/024/732/434/large_2x/3d-dragon-egg-model-generative-ai-free-png.png" transform="translate(-65, -80)" />',

                    //
                    // text info
                    '<text x="5%" y="85%" font-family="Arial" font-size="15" fill="#000" text-anchor="start">',
                    "ElementaNFT #",
                    Strings.toString(_tokenId),
                    "</text>",
                    '<text x="5%" y="90%" font-family="Arial" font-size="10" fill="#000" text-anchor="start">',
                    "Level : ",
                    Strings.toString(s.elementaNFTs[_tokenId].level),
                    "</text>",
                    '<text x="5%" y="95%" font-family="Arial" font-size="10" fill="#000" text-anchor="start">',
                    "&#128150; x ",
                    Strings.toString(s.elementaNFTs[_tokenId].heartPoint),
                    "</text>",
                    "</svg>"
                )
            );
    }

    function _getEquipmentSVG(
        uint _tokenId
    ) internal view returns (ElementaNFT memory) {
        return s.elementaNFTs[_tokenId];
    }
}
