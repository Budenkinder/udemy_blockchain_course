// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "Cyfrin-Course/contracts/Interface_Baseclass/BaseStorage.sol";
import "Cyfrin-Course/contracts/Interface_Baseclass/IStorageInterface.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract MediumSimpleStorage is BaseStorage, IStorageInterface, ERC165 {
    bytes4 private constant _INTERFACE_ID_STORAGE_INTERFACE = type(IStorageInterface).interfaceId;
    
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == _INTERFACE_ID_STORAGE_INTERFACE || super.supportsInterface(interfaceId);
    }

    function retrievePerson(string memory _name) public view override returns(Person memory) {
        return nameToPerson[_name];
    } 

    function addPerson(string memory _name, uint256 _favoriteNumber) public override {
        Person memory person = Person({name: _name, favoriteNumber: _favoriteNumber});
        listOfPeople.push(person);
        nameToPerson[_name] = person;
    }

        function getInterfaceId() public view virtual override  returns (bytes4) {
        return _INTERFACE_ID_STORAGE_INTERFACE;
    }
}