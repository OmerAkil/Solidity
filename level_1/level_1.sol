//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

contract deneme {

    uint public luckyNumber = 32;

    function showMyNumber() public view returns(uint) {

        return luckyNumber;
    }

    function blank() public pure returns(uint, bool, string memory) {
        return(1, true, "cat"); // you can return multiple values like that 
    } 

    function blank2() public pure returns(uint x, bool y, string memory z) {
        x = 3;
        y = false;
        z = "whale"; // you can also return values by like that, if you have multiple values this might be more efficent 
    }
}