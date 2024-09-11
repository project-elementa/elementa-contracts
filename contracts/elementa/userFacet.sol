// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import {modifiersFacet} from "../shared/utils/modifiersFacet.sol";
import {IERC721} from "../shared/interfaces/IERC721.sol";

contract userFacet is modifiersFacet {

    event RegisterAddress(address indexed _address, uint indexed _nftId);

    function user_registerAddress(address _address) external onlyDelegateEOA {
        s.users[s.delegateEOAs[msg.sender].userId].reciveAddress = _address;
        s.users[s.delegateEOAs[msg.sender].userId].nftId = s.delegateEOAs[msg.sender].userIndex;
        // NFT mint to user
        s.delegateEOAs[msg.sender].isOwnNFT = true;

        IERC721(s.contracts["nft"]).diamondMint(_address, s.delegateEOAs[msg.sender].userIndex);

        emit RegisterAddress(_address, s.delegateEOAs[msg.sender].userIndex);
    }


}
