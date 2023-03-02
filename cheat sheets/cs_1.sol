=> TOPICS
/* Functions, keccak256(abi.encodePacked()), event declaring/emitting */

=> Use "_" when declaring a variable only for function like so:

/*  function createZombie (string memory _name, uint _dna) */

=> When declaring a function in solidity use memory keyword for strings, arrays etc. (uint is not included)
   
/*  function createZombie (string memory _name, uint _dna) */

=> Spesify ur function as private at first then change it to public if you need it

/*  function _createZombie (string memory _name, uint _dna) private */

/*  if your function is private then put _ before your function name*/

=> return value should be given in when declaring function

/*  function createZombie (string memory _name, uint _dna) private returns (uint) {

    } 

   **if we were to return a string value
    
   /* function createZombie (string memory _name, uint _dna) private returns (string memory) {

    }  dont forget memory !!!
*/
=> If your function is pure func (Which means doesnt even use any variable thats global (does not even read it)) put pure after private/public. If your func just reads from global data then put view.

/*  function createZombie (string memory _name, uint _dna) private view returns (uint) {

    return 5;
    } 
*/
=> Declaring event and using it

/*
    event NewZombie(uint zombieId, string name, uint dna);

    emit NewZombie(id, _name, _dna);
*/

=> Declaring arrays

/*
    string[size] public NAME;
*/

=> keccak256(abi.encodePacked(_name))

/*
    Turns string passed into it to an 256 bit thing. If you want to use it as uint typecast it as uint 
    uint(keccak256(abi.encodePacked(_name)))

    **There is no string compare method in solidity so use keccak256 and compare the results instead.
*/

=> array.push()

/*
    array.push() returns the length of an array. 

    You can use that to get last index of an array.

    last_item_index = array.push() - 1;
*/