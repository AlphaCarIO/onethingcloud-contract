pragma solidity >=0.4.16 <0.6.0;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract OrderManager is Ownable {

    using SafeMath for uint256;

    struct Order {
        string orderId; // 订单编号
        string orderType; // 订单类型
        string orderStatus; // 订单状态
        uint64 feeTotal; // 订单总金额
        uint16 passengerAmount; // 乘客数
        uint distance; // 行程距离
        string locationOrigin; // 出发地详情
        string locationDest; // 目标地详情
        uint64 createTime; // 创建时间（UTC时间戳）
        uint64 departureTime; // 出发时间，仅顺风车（UTC时间戳）
        //uint64 completeTime; // 完成时间（or取消）（UTC时间戳）
        //uint8 gradePassenger; // 乘客评分（0-5分），仅顺风车（int)
        //uint8 gradeDriver; // 车主评分（0-5分），仅顺风车（int)
        //string passengerId; // 乘客ID（脱敏），仅顺风车
        //string driverId; // 车主ID（脱敏）
        bool isVaild;
    }

    mapping(string => Order) orders;

    constructor() public {
    }

    function createOrder(string memory orderId, string memory orderType, string memory orderStatus, 
    uint64 feeTotal, uint16 passengerAmount, uint distance, string memory locationOrigin, string memory locationDest,
    uint64 createTime, uint64 departureTime) public onlyOwner returns(bool) {

        if (orders[orderId].isVaild) {
            return false;
        }

        orders[orderId] = Order(orderId, orderType, orderStatus, feeTotal, passengerAmount, distance, 
        locationOrigin, locationDest, createTime, departureTime, true);
        
        return true;
    }

    function modifyOrder(string memory orderId, string memory newOrderStatus) public onlyOwner returns(bool) {

        if (!orders[orderId].isVaild) {
            return false;
        }

        orders[orderId].orderStatus = newOrderStatus;

    }

    function getOrderById(string memory orderId) public view returns(string memory, string memory,
            uint64, uint16, uint, string memory, string memory, uint64, uint64){
        
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
            o.departureTime
        );
    }

}
