 // SPDX-License-Identifier: MIT

 pragma solidity 0.8.17;

 import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SampleSmartMoney is ReentrancyGuard{

    uint public currentBalance; 
    uint public lastReceivedValue;

    //the one who deployed the contract
    address public owner;

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawTo(address payable _to, uint amount, bytes memory payload) 
            external payable returns(bytes memory){
        
        (bool success, bytes memory returnData) = _to.call{value: amount}(payload);
         require(success, "Transfer failed."); 
         return returnData;   
    }
}