// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../EternalStorage.sol";

library EternalStorageAccessLibrary
{
    function setCityAndYears(address storageContract, string memory city, uint yearsLived) public
    {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        bytes32 userYearsKey = keccak256(abi.encode("userYears", msg.sender));

        EternalStorage(storageContract).setStringValue(userCityKey, city);
        EternalStorage(storageContract).setUIntValue(userYearsKey, yearsLived);
    }

    function getCity(address storageContract) public view returns (string memory){
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        return EternalStorage(storageContract).getStringValue(userCityKey);
    }

    function getYears(address storageContract) public view returns (uint){
        bytes32 userYearsKey = keccak256(abi.encode("userYears", msg.sender));
        return EternalStorage(storageContract).getUIntValue(userYearsKey);
    }
}

contract MyFavoriteCityV2 {
    using EternalStorageAccessLibrary for address;
    address public storageContract;

    constructor(address eternalStorageAddress) {
        storageContract = eternalStorageAddress;
    }

    function saveMyFavoriteCityAndYears(string memory city, uint yearsLived) public {
        storageContract.setCityAndYears(city, yearsLived);
    }

    function getMyFavoriteCityAndYears() public view returns (string memory, uint) {
        string memory city = storageContract.getCity();
        uint yearsLived = storageContract.getYears();

        return (city, yearsLived);
    }
}
