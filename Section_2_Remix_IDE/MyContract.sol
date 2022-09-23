// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract MyContract{

    string public ourString = "Hello World";

    // public for outside world for interaction
    // no return value
    function updateOurString(string memory _updateString) public {
        ourString = _updateString;
    }

}