 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*
https://medium.com/coinmonks/solidity-transfer-vs-send-vs-call-function-64c92cfc878a
*/

contract ContractBalanceDAO{

    mapping(address=> uint) public balances;

    function deposit() public payable{
        //msg.sender is the calling contract address
        //msg.value is the value of the calling contract address
        balances[msg.sender] += msg.value;
    }
}

contract CallingBalanceDAOContract{
    receive() external payable{}

    function depositToBalanceDAOByCallingTheContract(address _to) external{
        ContractBalanceDAO balanceDAO = ContractBalanceDAO(_to);
        // native transfer call
        balanceDAO.deposit{value: 100, gas:100000}();
    }
}