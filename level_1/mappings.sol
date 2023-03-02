//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

contract nestedMapping {
    
    // Normal mapping
    mapping (address => bool) public registered;

    function registerUser() public {
        require (registered[msg.sender] == false, "It is already registered");
        registered[msg.sender] = true;
    }

    // Nested mapping
    mapping (address => mapping(address => uint)) public debt;

    function incDebt(address _borrower, uint _amount) public returns(uint) {
        debt[msg.sender][_borrower] += _amount;
        return (debt[msg.sender][_borrower]); 
    }

    function decDebt(address _borrower, uint _amount) public returns(uint) {
        require(debt[msg.sender][_borrower] >=  _amount, "You can not pay more than you owe");
        debt[msg.sender][_borrower] -= _amount; 
        return (debt[msg.sender][_borrower]); 
    }
}


