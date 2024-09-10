// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AppStorage} from "../shared/storage/structs/AppStorage.sol";
import {modifiersFacet} from "../shared/utils/modifiersFacet.sol";

contract adminFacet is modifiersFacet {

    function setContract(string memory _name, address _address) external onlyAdmin {
        s.contracts[_name] = _address;
    }

    function getContract(string memory _name) external view returns (address) {
        return s.contracts[_name];
    }

    
}