// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../EternalStorage.sol";

contract MyFavoriteCity {
    EternalStorage public storageContract;

    constructor(address eternalStorageAddress) {
        storageContract = EternalStorage(eternalStorageAddress);
    }

    function saveMyFavoriteCity(string memory city) public {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        storageContract.setStringValue(userCityKey, city);
    }

    function getMyFavoriteCity() public view returns (string memory) {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        return storageContract.getStringValue(userCityKey);
    }
}