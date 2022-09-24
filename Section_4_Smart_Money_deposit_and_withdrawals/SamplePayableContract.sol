// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*

    IF THE MONEY IS TRANSFERED, IT IS LOCKED
    BECAUSE THERE IS NO FUNCTION TO TRANSFER 
    SOMEWHERE ELSE

*/
contract SamplePayableContract{
    string public myString = "Hello World";

    // function is public
    // can change storage 
    // the call of this function must be paid
    function updateString(string memory _newString) public payable{
        myString = _newString;
    }
}