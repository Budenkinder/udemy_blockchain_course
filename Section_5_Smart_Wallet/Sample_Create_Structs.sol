 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*

    Structs are much easier
    Easier to access
    Cheaper
    Smart Contracts objects are complex,
    because you need to check the access rights, ... and so on.
*/
contract Wallet{

    struct PaymentInfo{
        address from;
        uint amount;
    }
    PaymentInfo public payment;

    function payContract() public payable{
        payment.from = msg.sender;
        payment.amount = msg.value;
    }
}

