//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "Cyfrin-Course/contracts/Interface_Baseclass/BaseStorage.sol";
import "Cyfrin-Course/contracts/Interface_Baseclass/IStorageInterface.sol";

contract SmallSimpleStorage is BaseStorage, IStorageInterface{
    function retrievePerson(string memory _name) public view override returns(Person memory) {
        return nameToPerson[_name];
    } 

    function addPerson(string memory _name, uint256 _favoriteNumber) public override{
        Person memory person = Person({name:_name, favoriteNumber:_favoriteNumber});
        listOfPeople.push(person);
        nameToPerson[_name] = person;
    }
}


