 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*

https://medium.com/coinmonks/solidity-transfer-vs-send-vs-call-function-64c92cfc878a

Demo:
- Deploy TransferMoney with 5 ETH
-- Use call method for fallback
-- send for receive
- Deploy ReceiverMoneyOnlyReceive
-- use this address
- Deploy ReceiverMoneyOnlyFallback
-- use this address
*/
contract LogContracts{
    event LogOutput(string log);
}

contract TransferMoney is LogContracts{

    constructor() payable{}

    function deposit() external payable{}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getDeployedAddress() external view returns(address){
        return address(this);
    }

    //will throw an error, when out of gas
    function withdrawViaTransfer(address payable _to, uint256 balance) public{
        _to.transfer(balance);
        emit LogOutput("withdrawViaTransfer() => _to.transfer(balance)");
    }

    //will NOT throw an error, when out of gas
    //no hint for the user
    function withdrawViaSend(address payable _to, uint256 balance) public{
        //to catch the error, send returns a boolean
        bool success = _to.send(balance);
        emit LogOutput("withdrawViaSend() => _to.send(balance)");
        require(success, "withdrawViaSend() reverted");
    }

    /*
        The fallback function is called, because the dedicated function
        does not exists.
    */
    function withdrawViaCall_Func_Signature(address payable _to, uint256 balance) public{
        (bool success, ) = _to.call{gas :10000, value: balance}("func_signature(uint256 args)");
        emit LogOutput("withdrawViaCall_Func_Signature");
        require(success, "withdrawViaCall_Func_Signature() reverted");
    }

    function withdrawViaCall(address payable _to, uint256 balance) public{
        /* (bool sent, bytes memory data) = _to.call{gas :10000, value: msg.value}("func_signature(uint256 args)"); */
        (bool success, ) = _to.call{value: balance}("");
        emit LogOutput("withdrawViaCall() => msg.sender.call{value: balance}("")");
        require(success, "Failed to send Ether");
    }
}

contract ReceiverMoneyOnlyReceive is LogContracts{
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getDeployedAddress() external view returns(address){
        return address(this);
    }


    receive() external payable{
        emit LogOutput("ReceiverMoneyOnlyReceive => receive()");
    }
}

contract ReceiverMoneyOnlyFallback is LogContracts{
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getDeployedAddress() external view returns(address){
        return address(this);
    }

    fallback() external payable{
        emit LogOutput("ReceiverMoneyOnlyFallback => fallback()");
    }
}

contract ReceiverMoney is LogContracts{

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getDeployedAddress() external view returns(address){
        return address(this);
    }


    receive() external payable{
        emit LogOutput("receive()");
    }

    fallback() external payable{
        emit LogOutput("fallback()");
    }
}

/*
    fallback() or receive() ?
    
    Ether send to contract?
    is msg.data empty?
    yes - receive exists? Yes - call receive - otherwise fallback 
    no - fallback

*/