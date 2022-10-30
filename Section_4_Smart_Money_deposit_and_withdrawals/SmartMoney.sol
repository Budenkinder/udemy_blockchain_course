 // SPDX-License-Identifier: MIT

 pragma solidity 0.8.17;

 import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/*
    Our Account sent 1 Eth to the smart contact
    See the  balance
    Withdraw all to the sender
    Withdraw to a specific address
    in ETH

*/
contract SampleSmartMoney is ReentrancyGuard{

    uint public currentBalance; 
    uint public lastReceivedValue;

    //the one who deployed the contract
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function deposit() public payable{
        require(is1Ether(msg.value), "1 ether is required");
        currentBalance+=msg.value;
        lastReceivedValue = msg.value;        
    }

    function is1Ether(uint currentDeposit) internal pure returns (bool){
        return currentDeposit == 1 ether;
    }

    //to the owner
    function withdrawTo() external{
        require(isOwnerCalling(), "not the owner");
        (bool success, ) = owner.call{value: getContractBalance()}("");
        require(success, "Transfer failed.");
        currentBalance = 0;
        lastReceivedValue = 0;
    }

    function isOwnerCalling() internal view returns (bool){
        return owner == msg.sender;
    }

    //to any address
    function withdrawTo(address payable to) external payable{
        require(isOwnerCalling(), "not the owner");
        (bool success, ) = to.call{value: lastReceivedValue}("hallo");
        require(success, "Transfer failed.");
        currentBalance -= lastReceivedValue;
        lastReceivedValue = 0;
    }

        //let use the name transfer as this can be called by other contracts or by other owners
    //the payload should be passed by 3rd parties
    function transfer(address payable _to, uint amount, bytes memory payload) 
            external payable returns(bytes memory){
        
        (bool success, bytes memory returnData) = _to.call{value: amount}(payload);
         require(success, "Transfer failed."); 
         return returnData;   
    }
}