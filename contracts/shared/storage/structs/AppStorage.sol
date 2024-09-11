// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EnumerableSet} from "../../libraries/LibEnumerableSet.sol";
import {UintQueueLibrary} from "../../libraries/LibUintQueueLibrary.sol";

using EnumerableSet for EnumerableSet.UintSet;
using UintQueueLibrary for UintQueueLibrary.UintQueue;

enum UserType {
    Wallet,
    Telegram,
    Line
}

struct User {
    string userId;
    uint nftId;
    address reciveAddress;
    address delegateEOA;

    UserType userType;
}
struct DelegateEOA {
    uint userIndex;
    string userId;
    address connectAddress;
    bool isOwnNFT;
}

struct ElementaNFT {
    address owner;

    uint level;
    uint exp;

}

struct AppStorage {
    mapping(string => address) contracts;
    mapping(string => User) users;
    uint globalUserIndex;
    mapping(string => uint) userIndex;

    // delegate EOA Info
    mapping(address => DelegateEOA) delegateEOAs;


}
