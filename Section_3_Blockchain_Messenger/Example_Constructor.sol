// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

//https://blockchain-academy.hs-mittweida.de/courses/solidity-coding-beginners-to-intermediate/lessons/solidity-5-calling-other-contracts-visibility-state-access/topic/tx-origin-and-msg-sender/
contract ExampleConstructor{

    address public myAddress;
    //works, but would do a transaction
    //always called 
    //better use constructor
    //=> address public myAddressAsSender= msg.sender;

    constructor(address _someAddress){
        //called once and during deployment
        myAddress = _someAddress;
    }

    function setMyAddress(address _myAddress) public{
        myAddress = _myAddress;
    }

    function setMyAddressToMsgSender() public{
        myAddress = msg.sender;
    }
    
}