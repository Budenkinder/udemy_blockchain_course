// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 < 0.8.29;

contract SimpleStorage{
    uint256 favouriteNumber;

    function store(uint256 _favouriteNumber) public{
        favouriteNumber = _favouriteNumber;
    }

    function getFavouriteNumber() public view returns (uint){
        return favouriteNumber;
    }
}