// SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

enum EquipmentType {
    Outline, // grade
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
    // ...
    // ...
    // ...
}

enum UserType {
    Wallet,
    Telegram,
    Line
}
struct Inventory {
    // nft status inventory
    uint[10] equipmentItem;
    uint[10] ability;
}

struct ElementaItem {
    EquipmentType equipmentType;
    uint itemId;
    string name;
    bytes uri;
}
