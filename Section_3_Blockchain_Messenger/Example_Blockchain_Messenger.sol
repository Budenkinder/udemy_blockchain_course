// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*

    Tasks is:
    - store a string on the blockchain
    - readable for everyone
    - writable only for the person who deployed the SM on the first place
    - how many times the message was updated
*/
contract BlockchainMessenger{

    string chat_message;
    //just for debugging
    address public owner;
    uint chat_update_counter;

    constructor(){
        owner = msg.sender;
    }     

    function writeChatMessage(string memory _newChatMessage) public{
        require(owner == msg.sender, "Not the owner");
        chat_message = _newChatMessage;
        chat_update_counter++;
    }

    function getUpdateCounter() public view returns(uint){
        return chat_update_counter;
    }

    function readChatMessage() public view returns(string memory){
        return chat_message;
    }
    
}