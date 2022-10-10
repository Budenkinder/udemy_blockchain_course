 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*

 How this works

 Deploy Wallet contract
 - trigger payContract() func
 PaymentReceived contract will be created

 The payment member returns the address, where PaymentReceived was created

 In Remix use "At Address", BUT you have to select the right contact
*/
contract Wallet{

    PaymentReceived public payment;

    function payContract() public payable{
        payment = new PaymentReceived(msg.sender, msg.value);
    }
}

contract PaymentReceived{
    address public from;
    uint public amount;

    constructor(address _from, uint _amount){
        from = _from;
        amount = _amount;
    }
}