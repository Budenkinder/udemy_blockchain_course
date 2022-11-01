// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*
    How to use it (very simplified)

    - By using the sendToken func, we are sending an event
    - It is send via the network, which is used
    - e.x. for testing use metamask + the goerli test network
    - Write a javascript file (see in scripts), where the page is
      also registred via MetaMask + goerli
    - MetaMasks injects itself to the webpage
    - Within the javascript func you can catch the event 

    => The content of the java script file + html will be added
       intot he script folder
    => As javascript editor e.x use A Pen

    This is the result, when catching the event:
    {"address":"0xE82ED8afCD40b93f2B53ae3222753AE7D0B7e082","blockHash":"0xfa4c6ba58e193daeaca0fdf9d2446cf971ca1a23ee15be770dce27f8923fe852","blockNumber":7874000,"logIndex":36,"removed":false,"transactionHash":"0x84052686b1165f38c30c3725331ba4f6145be6715fc45743b294fa5a360c2e78","transactionIndex":30,"id":"log_12d82ec5","returnValues":{"0":"0x2c2f4d8EE1976B4f4fDC46B4B8fCb6E9A60A88d6","1":"0xE82ED8afCD40b93f2B53ae3222753AE7D0B7e082","2":"10","_from":"0x2c2f4d8EE1976B4f4fDC46B4B8fCb6E9A60A88d6","_to":"0xE82ED8afCD40b93f2B53ae3222753AE7D0B7e082","_amount":"10"},"event":"TokensSent","signature":"0xe607861baff3d292b19188affe88c1a72bdcb69d3015f18bb2cd0bf5349cc3e1","raw":{"data":"0x0000000000000000000000002c2f4d8ee1976b4f4fdc46b4b8fcb6e9a60a88d6000000000000000000000000e82ed8afcd40b93f2b53ae3222753ae7d0b7e082000000000000000000000000000000000000000000000000000000000000000a","topics":["0xe607861baff3d292b19188affe88c1a72bdcb69d3015f18bb2cd0bf5349cc3e1"]}}
*/
contract EventSample{

    mapping(address => uint) public tokenBalance;

    event TokensSent(address indexed _from, address indexed _to, uint _amount);

    constructor(){
        tokenBalance[msg.sender] = 100;
    }

    function decreaseTokenBalance(address ofAddress, uint decreaseBy) internal {
        tokenBalance[ofAddress] -= decreaseBy;        
    }

    function increaseTokenBalance(address ofAddress, uint increaseBy) internal {
        tokenBalance[ofAddress] += increaseBy;
    }

    function sendToken(address _to, uint _amount) public returns(bool){
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        decreaseTokenBalance(msg.sender,_amount);
        increaseTokenBalance(_to, _amount);
        emit TokensSent(msg.sender, _to, _amount); 
        return true;
    }

}