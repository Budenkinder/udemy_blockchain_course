// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract MyContract{

    uint256 public balance;

    string public ourString = "Hello World";

    constructor() {
    }

    function updateOurString(string memory _updateString) public {
        ourString = _updateString;
    }

    receive() external payable{ 
        
    }
}