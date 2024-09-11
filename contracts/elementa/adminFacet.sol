// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {UserType, User} from "../shared/storage/structs/AppStorage.sol";
import {modifiersFacet} from "../shared/utils/modifiersFacet.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract adminFacet is modifiersFacet {
    using Strings for *;

    event RegisterUser(
        UserType indexed _type,
        string indexed userId,
        uint indexed userIndex
    );

    function setContract(
        string memory _name,
        address _address
    ) external onlyAdmin {
        s.contracts[_name] = _address;
    }

    function getContract(string memory _name) external view returns (address) {
        return s.contracts[_name];
    }

    // User Registration
    function admin_registerMessengerUser(
        UserType _type,
        string memory _userId,
        address _delegateEOA
    ) external onlyAdmin {
        string memory userId = lower(_userId);

        s.users[userId].userId = userId;
        s.users[userId].userType = _type;
        s.users[userId].delegateEOA = _delegateEOA;
        s.userIndex[userId] = s.globalUserIndex;

        emit RegisterUser(_type, userId, s.userIndex[userId]);

        s.globalUserIndex++;
    }

    function admin_registerWalletUser(address _delegateEOA) external onlyAdmin {
        string memory userId = lower(Strings.toHexString(msg.sender));

        s.users[userId].userId = userId;
        s.users[userId].userType = UserType.Wallet;
        s.users[userId].delegateEOA = _delegateEOA;
        s.userIndex[userId] = s.globalUserIndex;

        emit RegisterUser(UserType.Wallet, userId, s.userIndex[userId]);

        s.globalUserIndex++;
    }

    function admin_setGlobalUserIndex(uint _index) external onlyAdmin {
        s.globalUserIndex = _index;
    }

    //
    //
    //
    //
    // lower functions
    function _lower(bytes1 _b1) private pure returns (bytes1) {
        if (_b1 >= 0x41 && _b1 <= 0x5A) {
            return bytes1(uint8(_b1) + 32);
        }

        return _b1;
    }

    function lower(string memory _base) internal pure returns (string memory) {
        bytes memory _baseBytes = bytes(_base);
        for (uint i = 0; i < _baseBytes.length; i++) {
            _baseBytes[i] = _lower(_baseBytes[i]);
        }
        return string(_baseBytes);
    }
}
