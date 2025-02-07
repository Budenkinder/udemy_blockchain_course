//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "Cyfrin-Course/contracts/Interface_Baseclass/SmallSimpleStorage.sol";
import "Cyfrin-Course/contracts/Interface_Baseclass/IPerson.sol";

contract StorageFactory is IPerson{

    address[] public listOfMixStorages;
    Person public person;
    
    function createSimpleStorage(string memory _name, uint256 _favoriteNumber) public returns(SmallSimpleStorage){     
        SmallSimpleStorage sss = new SmallSimpleStorage();
        sss.addPerson(_name, _favoriteNumber);   
        address simpleStorage = address(sss);
        listOfMixStorages.push(simpleStorage);
        return sss;
    }

    function getSimpleStorageInstance(uint _randomIndex, string memory _name) public {
        require(_randomIndex < listOfMixStorages.length, "Index out of bounds");
        address simpleStorageAddress = listOfMixStorages[_randomIndex];
        SmallSimpleStorage sss = SmallSimpleStorage(simpleStorageAddress);
        person = sss.retrievePerson(_name);
    }
}