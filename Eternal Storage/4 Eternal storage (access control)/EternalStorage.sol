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
    function getUIntValue(bytes32 record) external view returns (uint256) {
        return uintStorage[record];
    }

    function getIntValue(bytes32 record) external view returns (int256) {
        return intStorage[record];
    }

    function getAddressValue(bytes32 record) external view returns (address) {
        return addressStorage[record];
    }

    function getBoolValue(bytes32 record) external view returns (bool) {
        return boolStorage[record];
    }

    function getBytesValue(bytes32 record) external view returns (bytes memory) {
        return bytesStorage[record];
    }

    function getStringValue(bytes32 record) external view returns (string memory) {
        return stringStorage[record];
    }

    // Setter functions with onlyAuthorizedContract modifier
    function setUIntValue(bytes32 record, uint256 value) external onlyAuthorizedContract {
        uintStorage[record] = value;
    }

    function setIntValue(bytes32 record, int256 value) external onlyAuthorizedContract {
        intStorage[record] = value;
    }

    function setAddressValue(bytes32 record, address value) external onlyAuthorizedContract {
        addressStorage[record] = value;
    }

    function setBoolValue(bytes32 record, bool value) external onlyAuthorizedContract {
        boolStorage[record] = value;
    }

    function setBytesValue(bytes32 record, bytes memory value) external onlyAuthorizedContract {
        bytesStorage[record] = value;
    }

    function setStringValue(bytes32 record, string memory value) external onlyAuthorizedContract {
        stringStorage[record] = value;
    }
}