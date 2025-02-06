//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract BaseSimpleStorage{

    uint256 myFavoriteNumber;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string=> uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public{
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    } 

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person({name:_name, favoriteNumber:_favoriteNumber}));
    }
}

contract SmallSimpleStorage is BaseSimpleStorage{
}

contract MediumSimpleStorage is BaseSimpleStorage{

}

contract LargeSimpleStorage is BaseSimpleStorage{

}

