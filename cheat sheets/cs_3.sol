=> TOPICS
/* Inheritance, Ownable, Function Modifiers, Gas, */


=> Inheritance (Solving the problem of hardcoding)

/*
    Remember in lvl_2 we hardcoded the part where we defined the cryptoKittiesAddress
*/
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    SomeNameInterface kittyContract = SomeNameInterface(ckAddress);
/*
    In this approach we are gonna create an external function to set address.
*/
    KittyInterface kittyContract;

    function setKittyContractAddress(address _address) external {
    kittyContract = KittyInterface(_address);



=> Ownable

/*
    To use ownable contract in your contract import it. And to use it in your contract remember what we've done in lvl_2 inheritance. From now on we can use functions at ownable.
*/
    import ("./ownable.sol");

    contract mainContract is Ownable {

    }



=> Function Modifiers

/* 
    After we import the ownable.sol if you look at it you realize there is something called modifier. Modifiers are just like functions but they are used to modify the functions and change their behaviour. To use it we attach their names end of the function. Like so (modifier onlyOwner()):
*/
    modifier onlyOwner() {
        require(isOwner());
        _; // when it hits the _; statement in onlyOwner, it goes back and executes the code inside renounceOwnership.
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
/*
    Function Modifiers with arguments
*/
    // A mapping to store a user's age:
    mapping (uint => uint) public age;

    // Modifier that requires this user to be older than a certain age:
    modifier olderThan(uint _age, uint _userId) {
        require(age[_userId] >= _age);
        _;
    }

    // Must be older than 16 to drive a car (in the US, at least).
    // We can call the `olderThan` modifier with arguments like so:
    function driveCar(uint _userId) public olderThan(16, _userId) {
        // Some function logic
    }
/*
    You can see here that the olderThan modifier takes arguments just like a function does. And that the driveCar function passes its arguments (_userId) to the modifier.

    One more example for modifier:
*/
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;

/* Note: calldata is somehow similar to memory, but it's only available to external functions. */




=> ******* Gas *******

/*
Normally there's no benefit to using these sub-types because Solidity reserves 256 bits of storage regardless of the uint size. For example, using uint8 instead of uint (uint256) won't save you any gas.

But there's an exception to this: inside structs.

If you have multiple uints inside a struct, using a smaller-sized uint when possible will allow Solidity to pack these variables together to take up less storage.
*/
struct NormalStruct {
    uint a;
    uint b;
    uint c;
  }
  
struct MiniMe {
    uint32 a;
    uint32 b;
    uint c;
  }
/* 
mini` will cost less gas than `normal` because of struct packing BUT
be careful about that:
You'll also want to cluster identical data types together (i.e. put them next to each other in the struct) so that Solidity can minimize the required storage space.

For example, a struct with fields uint c; uint32 a; uint32 b; will cost less gas than a struct with fields uint32 a; uint c; uint32 b; because the uint32 fields are clustered together.
*/



=> Declaring arrays in memory 

/*
  Since storage costs gas to users, this is way cheaper than using storage if it's in an external view function.
*/
    function getArray() external pure returns(uint[] memory) {
        // Instantiate a new array in memory with a length of 3
        uint[] memory values = new uint[](3);
    
        // Put some values to it
        values[0] = 1;
        values[1] = 2;
        values[2] = 3;
    
        return values;
    }

    /* Note: memory arrays must be created with a length argument (in this example, 3). They currently cannot be resized like storage arrays can with array.push(), although this may be changed in a future version of Solidity.*/
    // One more example:
    
    function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

/*
Up until now, we've covered quite a few function modifiers. It can be difficult to try to remember everything, so let's run through a quick review:

We have visibility modifiers that control when and where the function can be called from: private means it's only callable from other functions inside the contract; internal is like private but can also be called by contracts that inherit from this one; external can only be called outside the contract; and finally public can be called anywhere, both internally and externally.

We also have state modifiers, which tell us how the function interacts with the BlockChain: view tells us that by running the function, no data will be saved/changed. pure tells us that not only does the function not save any data to the blockchain, but it also doesn't read any data from the blockchain. Both of these don't cost any gas to call if they're called externally from outside the contract (but they do cost gas if called internally by another function).

Then we have custom modifiers, which we learned about in Lesson 3: onlyOwner and aboveLevel, for example. For these we can define custom logic to determine how they affect a function.
*/




/* You can also pass struct to functions like. BUT this is only for internal and private functions*/

struct Zombie{
    string name;
    uint dna;
    uint32 level;
}

function _doStuff(Zombie storage _zombie) internal {
    // do stuff with _zombie
  }
