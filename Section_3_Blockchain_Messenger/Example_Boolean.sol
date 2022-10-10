// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract ExampleBoolean{
    //default value is false like always
    bool public myBool;

    function setMyBool(bool _myBool) public{
        myBool = _myBool;
    }
}