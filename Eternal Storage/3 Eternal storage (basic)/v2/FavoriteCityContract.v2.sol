// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../EternalStorage.sol";

contract MyFavoriteCityV2 {
    EternalStorage public storageContract;

    constructor(address eternalStorageAddress) {
        storageContract = EternalStorage(eternalStorageAddress);
    }

    function saveMyFavoriteCityAndYears(string memory city, uint256 yearsLived) public {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        bytes32 userYearsKey = keccak256(abi.encode("userYears", msg.sender));

        storageContract.setStringValue(userCityKey, city);
        storageContract.setUIntValue(userYearsKey, yearsLived);
    }

    function getMyFavoriteCityAndYears() public view returns (string memory, uint256) {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        bytes32 userYearsKey = keccak256(abi.encode("userYears", msg.sender));

        string memory city = storageContract.getStringValue(userCityKey);
        uint256 yearsLived = storageContract.getUIntValue(userYearsKey);

        return (city, yearsLived);
    }
}
