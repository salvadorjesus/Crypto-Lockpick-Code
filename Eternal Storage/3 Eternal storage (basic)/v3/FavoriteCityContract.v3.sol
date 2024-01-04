// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../EternalStorage.sol";

struct FavoritePlace {
    string name;
    string typeOfSite;
    bool isFree;
}

contract MyFavoriteCityV3 {
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

    function saveMyFavoritePlace(string memory placeName, string memory typeOfSite, bool isFree) public {
        bytes32 userPlaceKey = keccak256(abi.encode("userFavoritePlace", msg.sender));

        FavoritePlace memory newFavoritePlace = FavoritePlace({
            name: placeName,
            typeOfSite: typeOfSite,
            isFree: isFree
        });

        bytes memory placeData = abi.encode(newFavoritePlace);

        storageContract.setBytesValue(userPlaceKey, placeData);
    }

    function getMyFavoriteCityAndYears() public view returns (string memory, uint256) {
        bytes32 userCityKey = keccak256(abi.encode("userCity", msg.sender));
        bytes32 userYearsKey = keccak256(abi.encode("userYears", msg.sender));

        string memory city = storageContract.getStringValue(userCityKey);
        uint256 yearsLived = storageContract.getUIntValue(userYearsKey);

        return (city, yearsLived);
    }

    function getMyFavoritePlace() public view returns (FavoritePlace memory) {
        bytes32 userPlaceKey = keccak256(abi.encode("userFavoritePlace", msg.sender));
        bytes memory placeData = storageContract.getBytesValue(userPlaceKey);

        FavoritePlace memory favoritePlace;
        if (placeData.length == 0)
            favoritePlace = FavoritePlace("", "", false);
        else
            favoritePlace = abi.decode(placeData, (FavoritePlace));

        return favoritePlace;
    }
}
