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
*/
contract EventSample{

    mapping(address => uint) public tokenBalance;

    event TokensSent(address _from, address _to, uint _amount);

    constructor(){
        tokenBalance[msg.sender] = 100;
    }

    receive() external payable{ }

    function sendToken(address _to, uint _amount) public returns(bool){
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount); 

        return true;
    }

}