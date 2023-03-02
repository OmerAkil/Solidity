=> TOPICS
/* Address, mapping, require, inheritance, import, Storage vs Memory, PublicPrivate vs InternalExternal, interacting with other contracts, constant vs immutable */


=> ADDRESS
/*
    Functions just sit on ethereum blockchain, only when someone calls it, it works. Since someone calls the function we always have "msg.sender". "msg.sender" is an address.
*/

=> mapping

/*
    Think of it like a list.
*/
    mapping (key => value) public nameToMapping;
  
    mapping (address => uint) public accountBalance;
/*
    so 
    accountBalance[msg.sender] gives the value(uint) which is account balance of an msg.sender.
    You call mappings as arrays.
*/

=> require

/*
    with require, function will throw an error and stop executing if some condition is not true.

    Usage: require(condition);
*/
    require(ownerZombieCount[msg.sender] == 0);

=> Inheritance

    contract Doge {
        function catchphrase() public returns (string memory) {
            return "So Wow CryptoDoge";
        }
    }

    contract BabyDoge is Doge {
        function anotherCatchphrase() public returns (string memory) {
            return "Such Moon BabyDoge";
        }
    }
/*
    BabyDoge inherits from Doge. That means if you compile and deploy BabyDoge, it will have access to both catchphrase() and anotherCatchphrase() (and any other public functions we may define on Doge).
*/

=> Import

    import "./someothercontract.sol";

    contract newContract is SomeOtherContract {

    }
/*
    When you split your work into different files and use it as its one piece again.
*/

=> Storage vs Memory

/*
    Storage refers to variables stored permanently on the blockchain. Memory variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.

    Most of the time you don't need to use these keywords because Solidity handles them by default. State variables (variables declared outside of functions) are by default storage and written permanently to the blockchain, while variables declared inside functions are memory and will disappear when the function call ends.

    However, there are times when you do need to use these keywords, namely when dealing with structs and arrays within functions.
*/
    contract SandwichFactory {
        
        struct Sandwich {
        string name;
        string status;
        }   
    
    Sandwich[] sandwiches;
    
        function eatSandwich(uint _index) public {
            // Sandwich mySandwich = sandwiches[_index];

            // ^ Seems pretty straightforward, but solidity will give you a warning
            // telling you that you should explicitly declare `storage` or `memory` here.

            // So instead, you should declare with the `storage` keyword, like:
            Sandwich storage mySandwich = sandwiches[_index];
            // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
            // in storage, and...
            mySandwich.status = "Eaten!";
            // ...this will permanently change `sandwiches[_index]` on the blockchain.

            // If you just want a copy, you can use `memory`:
            Sandwich memory anotherSandwich = sandwiches[_index + 1];
            // ...in which case `anotherSandwich` will simply be a copy of the 
            // data in memory, and...
            anotherSandwich.status = "Eaten!";
            // ...will just modify the temporary variable and have no effect 
            // on `sandwiches[_index + 1]`. But you can do this:
            sandwiches[_index + 1] = anotherSandwich;
            // ...if you want to copy the changes back into blockchain storage.
        }
    }

=> PublicPrivate vs InternalExternal

/*
    internal is the same as private, except that it's also accessible to contracts that inherit from this contract.
    if we use internal instead of private in some cases, that would solve the problem. 

    external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.
*/

=> Interacting with other contracts

/*
    Lets just say there is a random contract
*/
    contract LuckyNumber {
        mapping(address => uint) numbers;
  
        function setNum(uint _num) public {
        numbers[msg.sender] = _num;
        }
    
        function getNum(address _myAddress) public view returns (uint) {
        return numbers[_myAddress];
        }
    }
/*
    And lets say I want to use that getNum function in my contract. I can use it by defining it like contract. And in this contract I just define functions that I want to use and leave it like that. 
*/
    contract kittyInterface {
        function getNum(address _myAddress) public view returns (uint);
    }
/*
    This is the part where you implement your contract (Well this part is hardcoded so its going to be changed at lvl_3)
*/
    address kittyInterfaceAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d; // The real contract address
    kittyInterface kittyContract = kittyInterface(kittyInterfaceAddress); // So now numberContract is pointing to other contract.
/*
    And when I want to call that function I call it by:   
*/
    numberContract.getNum(someAddress);


=> Constant vs Immutable

uint public constant numbb = 10;    //if you use constant you have to assign a value to it

// BUT

uint public immutable numbb;    // if you use immutable you can assign value in constructor

constructor(uint _number) {
    numbb = _number;
}

// you cant change the value later on in both of these declarations.



    