//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "Cyfrin-Course/contracts/Interface_Baseclass/SmallSimpleStorage.sol";
contract StorageFactory{

    address[] public listOfMixStorages;
    
    function createSimpleStorage() public returns(SmallSimpleStorage){     
        SmallSimpleStorage sss = new SmallSimpleStorage();
        sss.addPerson("Resul", 0);   
        address simpleStorage = address(sss);
        listOfMixStorages.push(simpleStorage);
        return sss;
    }

    //get a storage, check for its type, typecast
    //then get the person
    function getAStorage(){

    }
}