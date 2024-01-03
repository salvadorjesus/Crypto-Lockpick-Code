// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../EternalStorage.sol";

library EternalStorageAccessLibrary
{
    function setCity(address storageContract, string memory city) public
    {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        EternalStorage(storageContract).setStringValue(userCityKey, city);
    }

    function getCity(address storageContract) public view returns (string memory){
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        return EternalStorage(storageContract).getStringValue(userCityKey);
    }
}

contract MyFavoriteCity {
    using EternalStorageAccessLibrary for address;
    address public storageContract;

    constructor(address eternalStorageAddress) {
        storageContract = eternalStorageAddress;
    }

    function saveMyFavoriteCity(string memory city) public {
        storageContract.setCity(city);
    }

    function getMyFavoriteCity() public view returns (string memory) {
        return storageContract.getCity();
    }
}