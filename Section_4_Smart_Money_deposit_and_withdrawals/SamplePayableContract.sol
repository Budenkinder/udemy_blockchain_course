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
 contract SamplePayableContract{

     uint public lastValueSent;
     string public lastFunctionCalled; 

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