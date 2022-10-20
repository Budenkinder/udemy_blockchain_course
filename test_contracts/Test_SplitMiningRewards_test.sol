 // SPDX-License-Identifier: MIT

//pragma solidity 0.8.17;
pragma solidity >=0.6.0 <0.7.0;

import "remix_tests.sol";
import "remix_accounts.sol";
import "../Section_5_Smart_Wallet/Code_Review_Split_Rewards.sol";

contract test_Suite{

    SplitMiningRewards splitMiningRewards;
    address payable beneficiary;
    address payable costcenter;

    function beforeEach() public{
        // constructor(address payable _beneficiary, 
        // address payable _costcenter) public
        beneficiary = TestAccounts.getAccount(0);
        costcenter = TestAccounts.getAccount(1);
        splitMiningRewards(beneficiary, costcenter);
    }
    
}