// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 < 0.8.29;

//get funds from users
//withdraw funds
//set a minimum funding value in USD
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract YourFundedEvent{
    event funded(address from, uint256 amount);
}

contract YourDataFeedEvent{
    event LogAnswer(address indexed sender, int indexed _data);
    event LogRoundID(address indexed sender, uint80 indexed _data);
    event LogAnsweredInRound(address indexed sender, uint80 indexed _data);
    event LogStartedAt(address indexed sender, uint indexed _data);
    event LogTimeStamp(address indexed sender, uint indexed _data);
}

contract FundMe is YourFundedEvent, YourDataFeedEvent{


    AggregatorV3Interface internal chainlinkDataFeed;

    struct FundedFrom{
        address from;
        string name;
        string lastName;
        uint256 amountETH;
        int256 amountUSD;
    }

    //can have duplicate funders
    FundedFrom[] public funders; 

    uint256 public ethBalance = 0;
    int256 public fundInUSD = 0;
    int256 public ethPriceUSD = 0;

    uint80 public roundId = 0;
    int public answer = 0;
    uint public startedAt = 0;
    uint public timeStamp = 0;
    uint80 public answeredInRound = 0;

    uint8 public decimals = 0;

    address private owner;

    uint256 public minimumUsd = 5;

    constructor()  {
        owner = msg.sender;
        // deployed in sepholia testnet at that address
        //the smart-contract on that address is type-casted to this interface
        chainlinkDataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function getChainlinkDataFeedLatestAnswer() private returns (int) {
        // prettier-ignore
        (
            uint80 _roundID,
            int _answer,
            uint _startedAt,
            uint _timeStamp,
            uint80 _answeredInRound
        ) = chainlinkDataFeed.latestRoundData();

        emit LogRoundID(msg.sender, _roundID);
        emit LogAnswer(msg.sender, _answer);
        emit LogStartedAt(msg.sender, _startedAt);
        emit LogTimeStamp(msg.sender, _timeStamp);
        emit LogAnsweredInRound(msg.sender, _answeredInRound);
        //logging

        decimals = chainlinkDataFeed.decimals();
        ethPriceUSD = convertEthInUSD(decimals, _answer);
        
        return _answer;
    }

    function convertEthInUSD(uint8 _decimals, int _ethPrice) internal pure returns (int){
        require(10**_decimals != 0, "Division by zero");
        return _ethPrice / int(10**uint(_decimals));
    }

    function fundMe(string memory name, string memory lastname) external payable{
        //require(owner.balance >= 0.000005 ether, "Didn't send enough eth >= 0.000005");
        //ethBalance += msg.value;  // this is not the balance of contract, it's that of FundMe

        require(msg.value >= minimumUsd, "didnt send enough ETH");

        fundInUSD = (int256(msg.value) * getChainlinkDataFeedLatestAnswer()) / 1e18; // Convert ETH to USD

        FundedFrom memory fundedFrom = FundedFrom(msg.sender,
        name,
        lastname,
        msg.value, fundInUSD);
        funders.push(fundedFrom);

        emit funded(msg.sender, msg.value);
    }

    receive() external payable {}

    //you could do a self-destruct
    //only owner can do it
    //funds must be withdrawn to another address
}