//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

contract etherSend {

    mapping (address => uint256) balances;

    event failedTransfer(address _targetAddress, uint256 value);
    event succeededTransfer(address _targetAddress, uint256 value);

    function sendEther() payable external {
        balances[msg.sender] += msg.value;
    }

    function myBalance() external view returns(uint256) {
        return(balances[msg.sender]);
    }

    function withdraw(address payable _targetAddress, uint256 _amount) external {
        _targetAddress.transfer(_amount); // transfer automatically reverts if its not payable
        balances[msg.sender] -= _amount; 
        //besides of transfer function there are also send() and call(). You may want to search about it. 
        
        //payable(msg.sender).transfer(balances[msg.sender]);
    }

    /* receive() and fallback()
    if you want to send eth directly to the contract you can use these.
    receive() => you send only eth.
    fallback() => you send data + eth.
    */

    uint receiveCount = 0;
    uint fallbackCount = 0;
    receive() external payable { 
        receiveCount++;         // if you only send eth receiveCount will increase.
    }

    fallback() external payable {
        fallbackCount++;        // if you send eth + data(which is hexadec) fallbackCount will increase.
    }
    //if you dont have receive() in your contract but fallback(),
    //even if you dont send data fallbackCount will increase.
}