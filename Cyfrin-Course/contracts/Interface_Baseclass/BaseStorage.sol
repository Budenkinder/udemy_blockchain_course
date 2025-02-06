//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "Cyfrin-Course/contracts/Interface_Baseclass/IStorageInterface.sol";

abstract contract BaseStorage is IPerson{

    Person[] public listOfPeople;

    mapping(string=> Person) public nameToPerson;
}
