// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {AppStorage} from "../storage/facets/AppStorageFacet.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract modifiersFacet {
    AppStorage internal s;

    modifier onlyAdmin() {
        LibDiamond.enforceIsContractOwner();
        _;
    }

    modifier onlyDelegateEOA() {
        require(
            s.delegateEOAs[msg.sender].userIndex != 0,
            "ModifiersFacet: not delegate EOA"
        );
        _;
    }
}
