// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract ExampleAddressTypes{

    //20 bytes
    address public someAddress;

    function setSomeAddress(address _someAddress) public{
        someAddress = _someAddress;
    }

    function getAddressBalance() public view returns(uint256){
        return someAddress.balance;
    }
}