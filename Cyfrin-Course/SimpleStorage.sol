// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 < 0.8.29;

contract SimpleStorage{
    uint256 favoriteNumber;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    Person public engineer = Person({
        favoriteNumber:7,name:"John"
    });

    Person public teacher = Person({favoriteNumber:3,name:"Alina"});


    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }

    function getfavoriteNumber() public view returns (uint){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        listOfPeople.push(Person(_favoriteNumber, _name));
    }
}