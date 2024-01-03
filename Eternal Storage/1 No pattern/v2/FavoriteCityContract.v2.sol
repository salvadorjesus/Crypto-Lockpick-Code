// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyFavoriteCityV2 {
    mapping(address => string) public favoriteCities;
    mapping(address => uint256) public yearsLivedInCity;

    function saveMyFavoriteCityAndYears(string memory city, uint256 yearsLived) public {
        favoriteCities[msg.sender] = city;
        yearsLivedInCity[msg.sender] = yearsLived;
    }
}
