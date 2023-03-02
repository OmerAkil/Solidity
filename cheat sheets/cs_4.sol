=> TOPICS
/* payable, withdraw, random number */

=> Payable

/*
    Remember we discussed about function modifiers at the end of the level_3. Payable is another function modifier that add some cool stuff to solidity and ethereum. It makes us able to pay eth via function calls.
    We add 'payable' when we are defining a function just like a normal modifiers. And later on you can check 
    msg.value if the value that is needed to run that function is paid. Thats all for now. 
    
    *The amount of eth sent is stored in the contracts eth account, and it will be trapped there — unless you add a function to withdraw the Ether from the contract.
*/
    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }



=> Withdraw

/*
    There is no specific function to withdraw your eth. You can write some function like that
*/
    contract GetPaid is Ownable {
        function withdraw() external onlyOwner {
            address payable _owner = address(uint160(owner()));
            _owner.transfer(address(this).balance);
        }
    }
/*
    =>address payable  

    It is important to note that you cannot transfer Ether to an address unless that address is of type address payable. But the _owner variable is of type uint160, meaning that we must explicitly cast it to address payable.

    => address(this).balance

    Balance stored on the contract. 

    =>uint160(owner())

    So in this part owner() function returns the address of owner which is 20 bytes classical as ethereum address.
*/


=> Random Number

    uint randNonce = 0;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
    }

/*
    What this would do is take the timestamp of now, the msg.sender, and an incrementing nonce (a number that is only ever used once, so we don't run the same hash function with the same input parameters twice).

    It would then "pack" the inputs and use keccak to convert them to a random hash. Next, it would convert that hash to a uint, and then use % 100 to take only the last 2 digits. This will give us a totally random number between 0 and 99. 
*/
