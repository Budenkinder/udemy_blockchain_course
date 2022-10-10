// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract ExampleIntegers{

    // default value is already 0
    // if still init with 0, it costs gas
    // leave it blank
    uint public myUIntZero = 0;

    //Effects on costs

    //already uint256
    uint public myUInt;
    //different sizes
    uint8 public myUInt8 = 250;

    int public myInt = -10;

    function incMyInt() public{
        myInt++;
    }

    function setMyUInt(uint _myUInt) public{
        myUInt = _myUInt;
    }

    function incMyUInt8() public{
        myUInt8++;
    }

}