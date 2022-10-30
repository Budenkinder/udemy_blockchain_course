// SPDX-License-Identifier: GPL-3.0
        
pragma solidity > 0.8.7 <0.9.0;

import "remix_tests.sol"; 

import "remix_accounts.sol";
import "./Code_Review_Split_Rewards.sol";

contract testSuite{

    SplitMiningRewards splitMiningRewards;
    address payable owner = payable(TestsAccounts.getAccount(0));
    address payable beneficiary = payable(TestsAccounts.getAccount(1));
    address payable costcenter = payable(TestsAccounts.getAccount(2));

    function beforeAll() public {
        // <instantiate contract>
        splitMiningRewards = new SplitMiningRewards(
            beneficiary,costcenter);
    }

    function transferingSth() public payable{
        (bool success,) = beneficiary.call{value: 100, gas:400000}("");
        Assert.ok(success, "");
        //Assert.equal(splitMiningRewards.getBalanceForTesting(), 200, 'token balance should be 20');
        //splitMiningRewards.depositJustForTest{gas:100000, value:200}();
    }
}
    