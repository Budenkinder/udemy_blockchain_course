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
//0x1d51057c0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000a6e657720537472696e6700000000000000000000000000000000000000000000
    function updateMyString(string memory newString) public payable{
        justAString = newString;
    }

    //payable is optional
    fallback() external payable{
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }

     receive() external payable{
         lastValueSent = msg.value;
         lastFunctionCalled = "received";
     }
 }