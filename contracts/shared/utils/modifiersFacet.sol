// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {AppStorage} from "../storage/facets/AppStorageFacet.sol";

contract modifiersFacet {
    AppStorage internal s;

    modifier onlyAdmin() {
        LibDiamond.enforceIsContractOwner();
        _;
    }

    modifier onlyDelegateEOA() {
        require(
            s.isDelegateAddress[msg.sender],
            "ModifiersFacet: not delegate EOA"
        );
        _;
    }
    
}