// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../EternalStorage.sol";

library EternalStorageAccessLibrary
{
    function setCityAndYears(address storageContract, string memory city, uint yearsLived) public {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        bytes32 userYearsKey = keccak256(abi.encode("userYears", msg.sender));

        EternalStorage(storageContract).setStringValue(userCityKey, city);
        EternalStorage(storageContract).setUIntValue(userYearsKey, yearsLived);
    }

    function setFavoritePlace(address storageContract, FavoritePlace memory favoritePlace) public {
        bytes32 userPlaceKey = keccak256(abi.encode("userFavoritePlace", msg.sender));
        bytes memory placeData = abi.encode(favoritePlace);

        EternalStorage(storageContract).setBytesValue(userPlaceKey, placeData);
    }

    function getCity(address storageContract) public view returns (string memory){
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        return EternalStorage(storageContract).getStringValue(userCityKey);
    }

    function getYears(address storageContract) public view returns (uint){
        bytes32 userYearsKey = keccak256(abi.encode("userYears", msg.sender));
        return EternalStorage(storageContract).getUIntValue(userYearsKey);
    }

    function getFavoritePlace(address storageContract) public view returns (FavoritePlace memory) {
        bytes32 userPlaceKey = keccak256(abi.encode("userFavoritePlace", msg.sender));
        bytes memory placeData = EternalStorage(storageContract).getBytesValue(userPlaceKey);
        
        FavoritePlace memory favoritePlace;
        if (placeData.length == 0)
            favoritePlace = FavoritePlace("", "", false);
        else
            favoritePlace = abi.decode(placeData, (FavoritePlace));

        return favoritePlace;
    }
}

struct FavoritePlace {
    string name;
    string typeOfSite;
    bool isFree;
}

contract MyFavoriteCityV3 {
    using EternalStorageAccessLibrary for address;
    address public storageContract;


    constructor(address eternalStorageAddress) {
        storageContract = eternalStorageAddress;
    }

    function saveMyFavoriteCityAndYears(string memory city, uint yearsLived) public {
        storageContract.setCityAndYears(city, yearsLived);
    }

    function saveMyFavoritePlace(string memory placeName, string memory typeOfSite, bool isFree) public {
        
        FavoritePlace memory newFavoritePlace = FavoritePlace({
            name: placeName,
            typeOfSite: typeOfSite,
            isFree: isFree
        });

        storageContract.setFavoritePlace(newFavoritePlace);
    }

    function getMyFavoriteCityAndYears() public view returns (string memory, uint) {
        string memory city = storageContract.getCity();
        uint256 yearsLived = storageContract.getYears();

        return (city, yearsLived);
    }

    function getMyFavoritePlace() public view returns (FavoritePlace memory) {
        return storageContract.getFavoritePlace();
    }
}
