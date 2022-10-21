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

        splitMiningRewards.depositJustForTest{gas:40000, value:200}();
    }

    function testSplitAndPay() public{
        //Assert.equal(splitMiningRewards.getBalanceForTesting(), 200, 'token balance should be 20');
    }
}
    