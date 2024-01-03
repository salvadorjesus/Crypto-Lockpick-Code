// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../v1/FavoriteCityContract.v1.sol";

contract MyFavoriteCityV3 {
    mapping(address => string) public favoriteCities;
    mapping(address => uint256) public yearsLivedInCity;

    constructor(address oldContractAddress, address[] memory userAddresses) {
        MyFavoriteCity oldContract = MyFavoriteCity(oldContractAddress);

        for (uint256 i = 0; i < userAddresses.length; i++) {
            address userAddress = userAddresses[i];
            favoriteCities[userAddress] = oldContract.favoriteCities(userAddress);
        }
    }

    function saveMyFavoriteCityAndYears(string memory city, uint256 yearsLived) public {
        favoriteCities[msg.sender] = city;
        yearsLivedInCity[msg.sender] = yearsLived;
    }
}
