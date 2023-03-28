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

contract Bank is LogContracts{

    //each customer has its map to balance
    mapping (address => uint256) private userBalances;

    constructor() payable{}

    function deposit() external payable {
        emit LogOutput("Bank deposits customers money.");
        userBalances[msg.sender] += msg.value;
    }

    //e.x. the customer wants all his money back
    function withdrawAll() external {
        emit LogOutput("Bank withdrawAll()");
        emit LogOutput("Bank checks if the customer has money");
        uint256 balance = getUserBalance(msg.sender);
        require(balance > 0, "Insufficient balance");

        emit LogOutput("Bank starts withdrawing customers money");
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");
    }

    function getMsgSenderAddress() external view returns(address){
        return msg.sender;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getDeployedAddress() external view returns(address){
        return address(this);
    }

    function getUserBalance(address _user) public view returns (uint256) {
        return userBalances[_user];
    }
}