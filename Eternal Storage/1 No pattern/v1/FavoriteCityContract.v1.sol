// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyFavoriteCity {
    mapping(address => string) public favoriteCities;
    
    function saveMyFavoriteCity(string memory city) public {
        favoriteCities[msg.sender] = city;
    }
}
