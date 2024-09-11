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

enum EquipmentType {
    Background,
    Head,
    Eyes,
    Mouth,
    Body,
    Hand,
    Pet,
    Badge
}

enum AbilityType {
    Luck
    // 
    // 
    // 
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
    // uint[10] equipment;
    
}

struct ElementaItem {
    EquipmentType equipmentType;
    uint itemId;
    string name;
    string uri;
}

struct AppStorage {
    mapping(string => address) contracts;
    mapping(string => User) users;
    uint globalUserIndex;
    mapping(string => uint) userIndex;
    // delegate EOA Info
    mapping(address => DelegateEOA) delegateEOAs;
}
