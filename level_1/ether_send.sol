//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

contract etherSend {
    uint[] a = [15, 10, 5];

    function change(uint _favnum) public returns(uint) {
        memory a[0] = _favnum;
        return a; 
    }

    function geta() view public returns(uint) {
        return a;
    }
}