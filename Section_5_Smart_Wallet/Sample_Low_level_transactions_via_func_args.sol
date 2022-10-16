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

    receive() external payable{
        //this will always be called, when retrieving money
        //an external contract can call this contract via native transfer call
        //the external contract might dont know the deposit function,
        //but still wants to send balance to this contact
        deposit();
    }
}

contract CallingBalanceDAOContract{
    receive() external payable{}

    function depositToBalanceDAOByCallingTheContract(address _to) external{
        // native transfer call
        (bool success,) = _to.call{value: 100, gas:400000}("");
        require(success, "Deposity func error");
    }
}