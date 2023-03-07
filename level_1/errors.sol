//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

contract errors {
    uint256 public totalBalance; // IDK why we create a variable for that even though we can see the balance. They said its because of the security 
    mapping (address => uint256) balances;

    error exceedingAmount(address user, uint256 exceedingAmount);
    error denyDirectPayment(string denial);

    event failedTransfer(address _targetAddress, uint256 value);
    event succeededTransfer(address _targetAddress, uint256 value);

    function sendEther() payable external checkAmount(msg.value) {
        totalBalance += msg.value;
        balances[msg.sender] += msg.value;
    }

    function myBalance() external view returns(uint256) {
        return(balances[msg.sender]);
    }
/*
    function withdraw(address payable _targetAddress, uint256 _amount) external checkAmount(_amount) {
        balances[msg.sender] -= _amount; 
        _targetAddress.transfer(_amount); 
    }

I am replacing that withdraw function with another one because they say it is not secure. Idk why yet.
*/  
    function withdraw(uint256 _amount) external checkAmount(_amount) {
        uint initialBalance = totalBalance;
        if(balances[msg.sender] < _amount) {
            //revert("Insufficent balance")
            // But instead we can create an error and revert an error.
            revert exceedingAmount(msg.sender, _amount - balances[msg.sender]);
        }

        totalBalance -= _amount;
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        assert(totalBalance < initialBalance); // it is not that necessary. Just to be sure. Assert generally used in testing phase of a code.
    }

    modifier checkAmount(uint _amount) {
        require(_amount != 0, "Amount can not be 0");
        _;
    }

    receive() external payable {
        revert denyDirectPayment("No direct payments allowed!");
    }

    fallback() external payable {
        revert denyDirectPayment("No direct payments allowed!");
    }
}