// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 < 0.8.29;

//get funds from users
//withdraw funds
//set a minimum funding value in USD
import "@openzeppelin/contracts/access/Ownable.sol";

contract FundMe is Ownable{

    uint256 public balance = 0;

    constructor() Ownable(address(this))  {
         // Child construction code goes here
    }

    //constructor(address initialOwner) Ownable(initialOwner) {}

    function fundMe() public payable{
        require(address(this).balance >= 1 ether, "Didn't send enough eth >= 1");
        balance += msg.value;  // this is not the balance of contract, it's that of FundMe
    }

    function withDraw() public {
        require(msg.sender == owner());
        payable (owner()).transfer(address(this).balance);
    }
}