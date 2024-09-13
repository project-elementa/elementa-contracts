// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import {modifiersFacet} from "../shared/utils/modifiersFacet.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {ElementaItem, EquipmentType, ElementaNFT} from "../shared/storage/structs/AppStorage.sol";
import {IERC721} from "../shared/interfaces/IERC721.sol";
import {svg} from "../shared/libraries/svg.sol";
import {Metadata, DisplayType} from "../shared/libraries/Metadata.sol";
import {json} from "../shared/libraries/json.sol";
import {Solarray} from "../shared/libraries/Solarray.sol";

import {LibString} from "solady/src/utils/LibString.sol";
contract nftFacet is modifiersFacet {
    using svg for *;
    using Metadata for *;

    function nft_getUri(uint _tokenId) external view returns (string memory) {
        return _getMetadata(_tokenId);
    }

    function _getMetadata(uint _tokenId) internal view returns (string memory) {
        // ElementaNFT memory nft = s.elementaNFTs[_tokenId];
        string memory metaData = Metadata.base64JsonDataURI(
            json.objectOf(
                Solarray.strings(
                    json.property(
                        "name",
                        string.concat(
                            "ElementaNFT #",
                            LibString.toString(_tokenId)
                        )
                    ),
                    json.property(
                        "description",
                        "Test Elementa dNFT, for testing"
                    ),
                    json.property(
                        "image",
                        Metadata.base64SvgDataURI(_generateSVG(_tokenId))
                    ),
                    json.property(
                        "attributes",
                        json.arrayOf(
                            Solarray.strings(
                                Metadata.attribute(
                                    "Level",
                                    LibString.toString(
                                        s.elementaNFTs[_tokenId].level
                                    ),
                                    DisplayType.BoostNumber
                                ),
                                Metadata.attribute(
                                    "Heart Point",
                                    LibString.toString(
                                        s.elementaNFTs[_tokenId].heartPoint
                                    ),
                                    DisplayType.Number
                                )
                            )
                        )
                    )
                )
            )
        );

        return metaData;
    }

    function _generateSVG(uint _tokenId) public view returns (string memory) {
        // bytes memory outline = s.elementaItems[EquipmentType.Outline][4].svgUri;
        // bytes memory background = s
        // .elementaItems[EquipmentType.Outline][4].svgUri;
        return
            string.concat(
                svg.top(
                    svg.prop("viewBox", "0 0 250 250"),
                    string.concat(
                        // Defining gradients
                        svg.el(
                            "defs",
                            "",
                            string.concat(
                                svg.linearGradient(
                                    string.concat(
                                        svg.prop("id", "outline"),
                                        svg.prop("x1", "0%"),
                                        svg.prop("y1", "0%"),
                                        svg.prop("x2", "100%"),
                                        svg.prop("y2", "100%")
                                    ),
                                    string.concat(
                                        svg.el(
                                            "stop",
                                            string.concat(
                                                svg.prop("offset", "0%"),
                                                svg.prop(
                                                    "style",
                                                    "stop-color:#ff00cc;stop-opacity:1"
                                                )
                                            ),
                                            svg.el(
                                                "animate",
                                                string.concat(
                                                    svg.prop(
                                                        "attributeName",
                                                        "stop-color"
                                                    ),
                                                    svg.prop(
                                                        "values",
                                                        "#ff00cc;#3333ff;#ff00cc"
                                                    ),
                                                    svg.prop("dur", "2s"),
                                                    svg.prop(
                                                        "repeatCount",
                                                        "indefinite"
                                                    )
                                                )
                                            )
                                        ),
                                        svg.el(
                                            "stop",
                                            string.concat(
                                                svg.prop("offset", "100%"),
                                                svg.prop(
                                                    "style",
                                                    "stop-color:#3333ff;stop-opacity:1"
                                                )
                                            ),
                                            svg.el(
                                                "animate",
                                                string.concat(
                                                    svg.prop(
                                                        "attributeName",
                                                        "stop-color"
                                                    ),
                                                    svg.prop(
                                                        "values",
                                                        "#3333ff;#ff00cc;#3333ff"
                                                    ),
                                                    svg.prop("dur", "2s"),
                                                    svg.prop(
                                                        "repeatCount",
                                                        "indefinite"
                                                    )
                                                )
                                            )
                                        )
                                    )
                                ),
                                svg.linearGradient(
                                    string.concat(
                                        svg.prop("id", "background"),
                                        svg.prop("x1", "0%"),
                                        svg.prop("x2", "0%"),
                                        svg.prop("y1", "0%"),
                                        svg.prop("y2", "100%")
                                    ),
                                    string.concat(
                                        svg.el(
                                            "stop",
                                            string.concat(
                                                svg.prop("offset", "0%"),
                                                svg.prop("stop-color", "yellow")
                                            ),
                                            ""
                                        ),
                                        svg.el(
                                            "stop",
                                            string.concat(
                                                svg.prop("offset", "100%"),
                                                svg.prop("stop-color", "red")
                                            ),
                                            ""
                                        )
                                    )
                                )
                            )
                        ),
                        // Defining background and border
                        svg.rect(
                            string.concat(
                                svg.prop("width", "100%"),
                                svg.prop("height", "100%"),
                                svg.prop("fill", svg.getDefURL("background")),
                                svg.prop("stroke", svg.getDefURL("outline")),
                                svg.prop("stroke-width", "7")
                            ),
                            ""
                        ),
                        // Adding dynamic text information
                        svg.text(
                            string.concat(
                                svg.prop("x", "5%"),
                                svg.prop("y", "85%"),
                                svg.prop("font-family", "Arial"),
                                svg.prop("font-size", "15"),
                                svg.prop("fill", "#000"),
                                svg.prop("text-anchor", "start")
                            ),
                            string.concat(
                                "ElementaNFT #",
                                LibString.toString(_tokenId)
                            )
                        ),
                        svg.text(
                            string.concat(
                                svg.prop("x", "5%"),
                                svg.prop("y", "90%"),
                                svg.prop("font-family", "Arial"),
                                svg.prop("font-size", "10"),
                                svg.prop("fill", "#000"),
                                svg.prop("text-anchor", "start")
                            ),
                            string.concat(
                                "Level: ",
                                LibString.toString(
                                    s.elementaNFTs[_tokenId].level
                                )
                            )
                        ),
                        svg.text(
                            string.concat(
                                svg.prop("x", "5%"),
                                svg.prop("y", "95%"),
                                svg.prop("font-family", "Arial"),
                                svg.prop("font-size", "10"),
                                svg.prop("fill", "#000"),
                                svg.prop("text-anchor", "start")
                            ),
                            string.concat(
                                "&#128150; x ",
                                LibString.toString(
                                    s.elementaNFTs[_tokenId].heartPoint
                                )
                            )
                        )
                    )
                )
            );
    }
    // character
    // ...here

    // '<image x="50%" y="50%" width="50%" height="50%" href="https://i.imgur.com/W718ova.png" transform="translate(-65, -80)" />',
    // '<image x="50%" y="50%" width="50%" height="50%" href="https://static.vecteezy.com/system/resources/previews/024/732/434/large_2x/3d-dragon-egg-model-generative-ai-free-png.png" transform="translate(-65, -80)" />',
    //

    function _getEquipmentSVG(
        uint _tokenId
    ) internal view returns (ElementaNFT memory) {
        return s.elementaNFTs[_tokenId];
    }

    function _updateUri(uint _tokenId) public {
        IERC721 nft = IERC721(s.contracts["nft"]);
        nft._update_metadata_uri(_tokenId);
    }
}
