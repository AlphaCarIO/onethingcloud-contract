pragma solidity ^0.5.0;

import './Ownable.sol';

contract OrderManager is Ownable {

    struct Order {
        string orderId; // 订单编号
        uint8 orderType; // 订单类型
        uint8 orderStatus; // 订单状态
        uint64 feeTotal; // 订单总金额
        uint16 passengerAmount; // 乘客数
        uint distance; // 行程距离
        string locationOrigin; // 出发地详情
        string locationDest; // 目标地详情
        uint64 createTime; // 创建时间（UTC时间戳）
        uint64 departureTime; // 出发时间，仅顺风车（UTC时间戳）
        bool isValid; // 标记位，判断数据是否存在
    }

    mapping(string => Order) orders;

    constructor(address account) Ownable(account) public {
    }

    function createOrder(string memory orderId, uint8 orderType, uint8 orderStatus, 
    uint64 feeTotal, uint16 passengerAmount, uint distance, string memory locationOrigin, string memory locationDest,
    uint64 createTime, uint64 departureTime) public onlyOwner returns(bool) {

        require(!orders[orderId].isValid);

        orders[orderId] = Order(orderId, orderType, orderStatus, feeTotal, passengerAmount, distance, 
        locationOrigin, locationDest, createTime, departureTime, true);
        
        return true;
    }

    function modifyOrder(string memory orderId, uint8 newOrderStatus) public onlyOwner returns(bool) {

        require(orders[orderId].isValid);

        orders[orderId].orderStatus = newOrderStatus;
        
        return true;

    }

    function getOrderById(string memory orderId) public view returns(uint8, uint8,
            uint64, uint16, uint, string memory, string memory, uint64, uint64, bool){
        
        Order memory o = orders[orderId];

        return (
            o.orderType,
            o.orderStatus,
            o.feeTotal,
            o.passengerAmount,
            o.distance,
            o.locationOrigin,
            o.locationDest,
            o.createTime,
            o.departureTime,
            o.isValid
        );
    }

}
