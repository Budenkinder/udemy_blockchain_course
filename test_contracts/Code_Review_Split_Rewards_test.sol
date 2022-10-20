// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "./Code_Review_Split_Rewards.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite{

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        // <instantiate contract>
        SplitMiningRewards splitMiningRewards = new SplitMiningRewards(
            payable(TestsAccounts.getAccount(0)),
            payable(TestsAccounts.getAccount(1)));
    }
}
    