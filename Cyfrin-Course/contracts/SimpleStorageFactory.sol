//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {SmallSimpleStorage} from "Cyfrin-Course/contracts/SimpleStorages.sol";

contract SimpleStorageFactory{

    address[] public listOfSimpleStorage;

    function storeFavoriteNumber(uint256 _favoriteNumber, uint256 index) public{
        SmallSimpleStorage storageContract = SmallSimpleStorage(listOfSimpleStorage[index]);
        storageContract.store(_favoriteNumber);
    }

    //0 simple, 1 medium, 2 large
    function createSimpleStorage() public returns(SmallSimpleStorage){
        
        address simpleStorage = address(new SmallSimpleStorage());

        listOfSimpleStorage.push(simpleStorage);

        return SmallSimpleStorage(simpleStorage);
    }

    function retrieveFavoritNumber(uint256 index)public view returns (uint256){
        SmallSimpleStorage sss = SmallSimpleStorage(listOfSimpleStorage[index]);
        return sss.retrieve();
    }

}