// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

//most important parts of Blockchain/smart contracts

/*
    msg is a public object available
    has properties like sender

    - account is calling the contract, it has the address in the sender
    - account with contact and with contract and the sender will contain 
      the address of the last caller
*/
contract ExampleMessageSender{

    address public someAddress;

    function updateSomeAddress() public {
        someAddress = msg.sender;
    }
}