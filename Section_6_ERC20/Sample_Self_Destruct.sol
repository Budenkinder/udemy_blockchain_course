// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*
    Be carefull by using this.
    If self-destruct is used, then the code inside the address is removed.
    You can still interact with the address, but nothing happens.

    Imagine if you send money to the address, it will be locked forever.

    - Send ether to this contract via receive
    - Do self_destruct
    - See money is back on the owner address
    - Send ether again
    - Do self_destruct
    - See money is locked forever

    Later on when advanced
    - see ugrade smart contracts
*/
contract Sample_Self_Destruct_Contract{

    address owner;

    constructor(){
        owner = msg.sender;
    }

    receive() external payable{}

    function self_destruct() public{
        selfdestruct(payable(owner));
    }
}
