//SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

import "./ownable.sol";

contract structs is ownable{

    enum Status {
        Taken,  //0
        Preparing,  //1
        Boxed,  //2
        Shipped//3
    }
    
    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        Status status;
    }

    Order[] public orders;
    uint256 public txCount;
    address public owner;

    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

    function createOrder(string memory _zipCode, uint256[] memory _products) external incTx() checkProducts(_products) returns(uint256) {
        //require(_products.length > 0, "There are no items in order list");  we've dealt this part with modifier

        orders.push(
            Order({
                customer: msg.sender,
                zipCode: _zipCode,
                products: _products,
                status: Status.Taken
            })
        );

        return orders.length - 1;
    }

    function changeOrderStatus(uint256 _orderId) external checkOrder(_orderId) isOwner() {
        //require(_orderId <= orders.length, "It is not a valid order"); We already covered this part with modifier
        Order storage myOrder = orders[_orderId];
        require(myOrder.status != Status.Shipped, "It is already delivered");

        if (myOrder.status == Status.Taken) {
            myOrder.status = Status.Preparing;
        } else if (myOrder.status == Status.Preparing) {
            myOrder.status = Status.Boxed;
        } else if (myOrder.status == Status.Boxed) {
            myOrder.status = Status.Shipped;
        }
    }

    function showOrder(uint256 _orderId) external view checkOrder(_orderId) returns(Order memory) {
        Order memory myOrder = orders[_orderId];
        require(msg.sender == owner || msg.sender == myOrder.customer);
        return myOrder;
    }

    modifier checkOrder(uint256 _orderId) {
        require(_orderId <= orders.length, "It is not a valid order");
        _; 
    }

    modifier checkProducts(uint256[] memory _products) {
        require(_products.length > 0, "There are no items in order list");
        _;
    }

    modifier incTx() {
        _;          // this time function works first, then modifier executes.
        txCount++;
    }
}