// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EternalStorage {

    address public owner = msg.sender;
    address public authorizedContract;

    mapping(bytes32 => uint256) private uintStorage;
    mapping(bytes32 => int256) private intStorage;
    mapping(bytes32 => address) private addressStorage;
    mapping(bytes32 => bool) private boolStorage;
    mapping(bytes32 => bytes) private bytesStorage;
    mapping(bytes32 => string) private stringStorage;

    //Modifier to allow modifications only from the designed client contract
    modifier onlyAuthorizedContract() {
       require(msg.sender == authorizedContract, "You are not the authorized contract.");
        _;
    }

    // Owner function to upgrade the authorizedContract
    function setAuthorizedContract(address newContract) public {
        require(msg.sender == owner, "You are not the owner.");
        authorizedContract = newContract;
    }

    // Getter functions
    function getUIntValue(bytes32 key) external view returns (uint256) {
        return uintStorage[key];
    }

    function getIntValue(bytes32 key) external view returns (int256) {
        return intStorage[key];
    }

    function getAddressValue(bytes32 key) external view returns (address) {
        return addressStorage[key];
    }

    function getBoolValue(bytes32 key) external view returns (bool) {
        return boolStorage[key];
    }

    function getBytesValue(bytes32 key) external view returns (bytes memory) {
        return bytesStorage[key];
    }

    function getStringValue(bytes32 key) external view returns (string memory) {
        return stringStorage[key];
    }

    // Setter functions with onlyAuthorizedContract modifier
    function setUIntValue(bytes32 key, uint256 value) external onlyAuthorizedContract {
        uintStorage[key] = value;
    }

    function setIntValue(bytes32 key, int256 value) external onlyAuthorizedContract {
        intStorage[key] = value;
    }

    function setAddressValue(bytes32 key, address value) external onlyAuthorizedContract {
        addressStorage[key] = value;
    }

    function setBoolValue(bytes32 key, bool value) external onlyAuthorizedContract {
        boolStorage[key] = value;
    }

    function setBytesValue(bytes32 key, bytes memory value) external onlyAuthorizedContract {
        bytesStorage[key] = value;
    }

    function setStringValue(bytes32 key, string memory value) external onlyAuthorizedContract {
        stringStorage[key] = value;
    }
}