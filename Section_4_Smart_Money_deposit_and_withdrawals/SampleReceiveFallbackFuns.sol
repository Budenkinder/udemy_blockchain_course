 // SPDX-License-Identifier: MIT

 pragma solidity 0.8.17;

/*
Understand the way funcs are called, see course

shows the different state of atomic transaction with/without data

https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/fallback-functions/

 A smart contact without any payable functions is not able
 to receive any money

 Only way is to implement the receive function
 => When there is no data

 To receive still money, when there is no data
 => we need the fallback function
*/
 contract SampleReceiveFallbackFuncs{

     uint public lastValueSent;
     string public lastFunctionCalled; 

    string public justAString;
    //first 4 bytes - function signature - see input data
    //using the keccak on the func name "updateMyString(string memory newString)"
    //it creates a new output, where the first 4 bytes are the same
    //the way how the evm knows what kind of function it calls
//0x1d51057c000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000016100000000000000000000000000000000000000000000000000000000000000
//use that in transact calldata, it works the same
//if unknown, the callback func will be triggered
    function updateMyString(string memory newString) external payable {
        justAString = newString;
    }

    //payable is optional
    //this can be used for an attack
    //can be hindered by => https://ethereum.stackexchange.com/questions/112128/how-this-modifier-nonreentrant-work
    fallback() external payable{
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }

     receive() external payable{
         lastValueSent = msg.value;
         lastFunctionCalled = "received";
     }
 }
