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
        //like java reflection, what if we dont know the func and the contract
        //https://docs.soliditylang.org/en/develop/abi-spec.html
        //https://solidity-by-example.org/abi-encode/
        //Because it is bytecode, the func needs to be re-keccak-ed
        bytes memory payload = abi.encodeWithSignature("deposit()");
        // native transfer call
        (bool success,) = _to.call{value: 100, gas:400000}(payload);
        require(success, "Deposity func error");
    }
}