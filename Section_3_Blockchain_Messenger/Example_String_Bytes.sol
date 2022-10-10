// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

// https://medium.com/coinmonks/ethereum-solidity-memory-vs-storage-which-to-use-in-local-functions-72b593c3703a
contract ExampleStringAndBytes{

    string public myString = "Hello World";

    //memory location is only during transaction, they are not persistent   
    //use storage for persistance, but is expensive
    function setMyString(string memory _myString) public{
        myString = _myString;
    }

    //view is a reading function and returns a value
    function compareStrings(string memory _myString) public view returns(bool){
        //no native comparison
        //return myString == _myString;

        //we are comparing the hashes of the strings
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }

    //conversion hard - you have to know UTF and special characters
    // DONT USE STRINGS
    bytes public myBytes = "Hello World";
}