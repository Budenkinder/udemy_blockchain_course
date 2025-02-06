//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "Cyfrin-Course/contracts/Interface_Baseclass/IPerson.sol";

interface IStorageInterface is IPerson{
    function retrievePerson(string memory _name) external view returns (Person memory);
    function addPerson(string memory _name, uint256 _favoriteNumber) external;
}