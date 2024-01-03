// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../v1/FavoriteCityContract.v1.sol";

contract MyFavoriteCityDataV2 {
    mapping(address => uint256) private yearsLivedInCity;

    function getYearsLivedInCity(address user) public view returns (uint256) {
        return yearsLivedInCity[user];
    }

    function setYearsLivedInCity(address user, uint256 yearsLived) public {
        yearsLivedInCity[user] = yearsLived;
    }
}

contract MyFavoriteCityLogicV2 {
    MyFavoriteCityData public cityDataContract;
    MyFavoriteCityDataV2 public yearsDataContract;

    constructor(address cityDataContractAddress) {
        cityDataContract = MyFavoriteCityData(cityDataContractAddress);
        yearsDataContract = new MyFavoriteCityDataV2();
    }

    function saveMyFavoriteCityAndYears(string memory city, uint256 yearsLived) public {
        cityDataContract.setFavoriteCity(msg.sender, city);
        yearsDataContract.setYearsLivedInCity(msg.sender, yearsLived);
    }

    function getMyFavoriteCityAndYears() public view returns (string memory, uint256) {
        return (cityDataContract.getFavoriteCity(msg.sender), yearsDataContract.getYearsLivedInCity(msg.sender));
    }
}
