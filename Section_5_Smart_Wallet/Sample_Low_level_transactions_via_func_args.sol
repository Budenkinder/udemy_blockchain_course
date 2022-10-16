 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*
https://medium.com/coinmonks/solidity-transfer-vs-send-vs-call-function-64c92cfc878a
*/

contract ContractBalanceDAO{

    mapping(address=> uint) balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }
}

contract CallingBalanceDAOContract{
    receive() external payable{}

    function depositToBalanceDAOByCallingTheContract(address _to) external{
        ContractBalanceDAO balanceDAO = ContractBalanceDAO(_to);
        // how does the value from this contract is moved to the external contract?
        // by using the anonymous function (like in Kotlin) 
        // using the call func arguments 
        balanceDAO.deposit();
    }
}