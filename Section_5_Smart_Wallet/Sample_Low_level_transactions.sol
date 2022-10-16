 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/**/
contract Sender{
    receive() external payable{}

    //will throw an error, when out of gas
    function withdrawTransfer(address payable _to) public{
        _to.transfer(10);
    }

    //will NOT throw an error, when out of gas
    //no hint for the user
    function withdrawSend(address payable _to) public{
        _to.send(10);
    }
}

contract ReceiverNoAction{
    //has no additional costs
    function balance() public view returns(uint){
        return address(this).balance;
    }

    receive() external payable{}
}

contract ReceiverAction{
    //has additional costs because, storage member is edited
    uint public balanceReceived;

    receive() external payable{
        balanceReceived += msg.value;
    }
}

