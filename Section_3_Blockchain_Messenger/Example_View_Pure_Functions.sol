// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract ExempleViewPure{

    //create a getter function as call
    //when deployed the value can be called
    uint public myStorageVariable;

    //will read the storage variable
    //not allowed to change the state inside the function
    function getMyStorageVariable() public view returns(uint){
        return myStorageVariable;
    }

    //pure functions get access outside of the scope of the function
    //pure functions can not change the state of the contract
    //pure will not even read the state variable (storage)
    function getAddition(uint a, uint b) public pure returns(uint){
        return a+b;
    }

    // works and writing to the blockchain
    //writing functions dont have return value
    //it is meant between smart contracts
    function addToStorage(uint a) public returns(uint){
        myStorageVariable = myStorageVariable + a;
        return a;
    }
}