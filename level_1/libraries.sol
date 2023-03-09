//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

library Human {
    
    struct Person {
        string name;
        uint8 age;
        bool alive;
    }

    uint constant idMod = 10 ** 11;

    function newborn(string calldata _name) public pure returns(Person memory, uint256) {
        uint rand = uint256(keccak256(abi.encodePacked(_name)));
        uint newId = rand % idMod;
        return(Person(_name, 0, true), newId);
    }

    function birthday(Person storage _person) public isAlive(_person) {
        _person.age += 1;
    }

    function death(Person storage _person) public isAlive(_person) {
        _person.alive = false;
    }

    modifier isAlive(Person memory _person) {
        require (_person.alive == true);
        _;
    }
}
    /*
    Lets say we have library Math{}. And there is a function like that in that library:

    function sum(uint256 _x, uint256 _y) public pure returns(uint256) {
        return (_x + _y);
    }

    We can call that function using 2 different ways:
    1- Math.sum(a,b)

    2- we define in our contract as:
        using Math for uint;
        a.sum(b);
    */

contract life {
    mapping (uint => Human.Person) people;

    function birth(string calldata _name) external returns(Human.Person memory, uint256) {
        Human.Person memory newborn;
        uint256 Id;
        (newborn, Id) = Human.newborn(_name);
        people[Id] = newborn;
        return(newborn, Id);
    }

    function newYear(uint256 _Id) public {
        Human.birthday(people[_Id]);        // when reaching a function in library its usage is like that.
    }   

    function die(uint256 _Id) public {
        Human.death(people[_Id]);
    }

    function infoPeople(uint256 _Id) external view returns(Human.Person memory) {
        return (people[_Id]); 
    }
}
