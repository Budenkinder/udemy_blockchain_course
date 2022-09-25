// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*

    IF THE MONEY IS TRANSFERED, IT IS LOCKED
    BECAUSE THERE IS NO FUNCTION TO TRANSFER 
    SOMEWHERE ELSE

*/
contract SamplePayableContract{
    string public myString = "Hello World";

    // function is public
    // can change storage 
    // the call of this function must be paid
    function updateString(string memory _newString) external payable{
        //only do when at least 1 ether
        if(msg.value == 1 ether){
            myString = _newString; 
        }else{
            (bool success, ) = msg.sender.call{value: msg.value}("");
            require(success, "Transfer failed.");

            //dont do this anymore
            //https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/
            //payable(msg.sender).transfer(msg.value);
        }
    }

    function getContractsBalance() public view returns(uint){
        return address(this).balance;
    }
}