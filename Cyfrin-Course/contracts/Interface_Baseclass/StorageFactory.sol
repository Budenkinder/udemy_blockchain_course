//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "Cyfrin-Course/contracts/Interface_Baseclass/SmallSimpleStorage.sol";
import "Cyfrin-Course/contracts/Interface_Baseclass/MediumSimpleStorage.sol";
import "Cyfrin-Course/contracts/Interface_Baseclass/LargeSimpleStorage.sol";
import "Cyfrin-Course/contracts/Interface_Baseclass/IPerson.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";

contract StorageFactory is IPerson{

    using ERC165Checker for address;

    enum StorageType { SMALL, MEDIUM, LARGE }

    mapping(StorageType => address) private storageContracts;

    constructor() {
        storageContracts[StorageType.SMALL] = address(new SmallSimpleStorage());
        storageContracts[StorageType.MEDIUM] = address(new MediumSimpleStorage());
        storageContracts[StorageType.LARGE] = address(new LargeSimpleStorage());
    }

    function isStorageContractTypeOf(address _contract, bytes4 _interfaceId) private view returns (bool) {
        return _contract.supportsInterface(_interfaceId);
    }


    address[] public listOfMixStorages;
    Person public person;
    
    function createSimpleStorage(uint256 storage_type, string memory _name, uint256 _favoriteNumber) public returns(address){     

        address simpleStorage;

        if(storage_type == 0){
            //small
            SmallSimpleStorage ss_storage = SmallSimpleStorage(storageContracts[StorageType.SMALL]);
            ss_storage.addPerson(_name, _favoriteNumber);   
            simpleStorage = address(ss_storage);
        }else if(storage_type == 1){
            //medium
            MediumSimpleStorage ms_storage = MediumSimpleStorage(storageContracts[StorageType.MEDIUM]);
            ms_storage.addPerson(_name, _favoriteNumber);   
            simpleStorage = address(ms_storage);
        }else {
            //large
            LargeSimpleStorage ls_storage = LargeSimpleStorage(storageContracts[StorageType.LARGE]);
            ls_storage.addPerson(_name, _favoriteNumber);   
            simpleStorage = address(ls_storage);
        }

        listOfMixStorages.push(simpleStorage);
        return simpleStorage;
    }

    function getSimpleStorageInstance(uint _randomIndex, string memory _name) public {
        require(_randomIndex < listOfMixStorages.length, "Index out of bounds");
        address simpleStorageAddress = listOfMixStorages[_randomIndex];
        
        // Check if the address is a SmallSimpleStorage contract
        if(isStorageContractTypeOf(simpleStorageAddress, SmallSimpleStorage(simpleStorageAddress).getInterfaceId())){
            SmallSimpleStorage ss_storage = SmallSimpleStorage(simpleStorageAddress);
            person = ss_storage.retrievePerson(_name);
        }else if(isStorageContractTypeOf(simpleStorageAddress, MediumSimpleStorage(simpleStorageAddress).getInterfaceId())){
            MediumSimpleStorage ms_storage = MediumSimpleStorage(simpleStorageAddress);
            person = ms_storage.retrievePerson(_name);
        }else{
            LargeSimpleStorage ls_storage = LargeSimpleStorage(simpleStorageAddress);
            person = ls_storage.retrievePerson(_name);
        }
    }
}