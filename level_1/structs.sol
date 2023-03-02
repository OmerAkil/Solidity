//SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

import "./ownable.sol";

contract structs is Ownable{

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

    function createOrder(string memory _zipCode, uint256[] memory _products) external returns(uint256) {
        require(_products.length > 0, "There are no items in order list");

        // Couple of ways to add order to the list

        // 1:
        // Order memory myOrder;
        // myOrder.customer = msg.sender;
        // myOrder.zipCode = _zipCode;
        // myOrder.products = _products;
        // myOrder.status = Status.Taken;
        // orders.push(myOrder);

        // 2:
        orders.push(
            Order({
                customer: msg.sender,
                zipCode: _zipCode,
                products: _products,
                status: Status.Taken
            })
        );

        // 3:
        // orders.push(Order(msg.sender, _zipCode, _products, Status.Taken));

        return orders.length - 1;
    }

    function changeOrderStatus(uint256 _orderId) external isOwner() {
        require(_orderId <= orders.length, "It is not a valid order"); 
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

    function showOrder(uint256 _orderId) external view returns(Order memory) {
        Order memory myOrder = orders[_orderId];
        require(msg.sender == myOrder.customer);
        return myOrder;
    } 
}