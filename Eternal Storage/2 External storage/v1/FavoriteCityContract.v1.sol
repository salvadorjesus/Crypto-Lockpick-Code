// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyFavoriteCityData {
    mapping(address => string) private favoriteCities;

    function getFavoriteCity(address user) public view returns (string memory) {
        return 
favoriteCities[user];
    }

    function setFavoriteCity(address user, string memory city) public {
        
favoriteCities[user] = city;
    }
}

contract MyFavoriteCityLogic {
    MyFavoriteCityData public dataContract;

    constructor() {
        dataContract = new MyFavoriteCityData();
    }

    function saveMyFavoriteCity(string memory city) public {
        dataContract.setFavoriteCity(msg.sender, city);
    }

    function getMyFavoriteCity() public view returns (string memory) {
        return dataContract.getFavoriteCity(msg.sender);
    }
}
