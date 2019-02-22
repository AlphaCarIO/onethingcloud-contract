const BigNumber = require('bignumber.js');
const OrderManager = artifacts.require('OrderManager');
const utils = require('./utils');

const fs = require("fs");

let orders = JSON.parse(fs.readFileSync("./test/order_sample_100.json", 'utf-8')).RECORDS
//console.log(orders);
let order1 = orders[0];
console.log(order1);
let order2 = orders[1];
console.log(order2);

let orderManager
let owner

// accounts[0] -> Contract Owner

contract('OrderManager', function (accounts) {
  beforeEach(async () => {
    owner = accounts[0]
    orderManager = await OrderManager.new({
      from: owner
    })
  })

  it('create order', async () => {

    await orderManager.createOrder(order1.orderId, order1.orderType, order1.orderStatus,
      order1.feeTotal, order1.passengerAmount, order1.distance,
      order1.locationOrigin, order1.locationDest, order1.createTime,
      order1.departureTime);

    let result = await orderManager.getOrderById(order1.orderId);

    assert.strictEqual(result[0], order1.orderType, "orderType is wrong!");
    assert.strictEqual(result[1], order1.orderStatus, "orderStatus is wrong!");
    assert.strictEqual(result[2].toString(), order1.feeTotal, "feeTotal is wrong!");
    assert.strictEqual(result[3].toString(), order1.passengerAmount, "passengerAmount is wrong!");
    assert.strictEqual(result[4].toString(), order1.distance, "distance is wrong!");
    assert.strictEqual(result[5], order1.locationOrigin, "locationOrigin is wrong!");
    assert.strictEqual(result[6], order1.locationDest, "locationDest is wrong!");
    assert.strictEqual(result[7].toString(), order1.createTime, "createTime is wrong!");
    assert.strictEqual(result[8].toString(), order1.departureTime, "departureTime is wrong!");

  })

  it('create duplicate order', async () => {

    await orderManager.createOrder(order1.orderId, order1.orderType, order1.orderStatus,
      order1.feeTotal, order1.passengerAmount, order1.distance,
      order1.locationOrigin, order1.locationDest, order1.createTime,
      order1.departureTime);

    await utils.expectThrow(orderManager.createOrder(order1.orderId, order1.orderType, order1.orderStatus,
      order1.feeTotal, order1.passengerAmount, order1.distance,
      order1.locationOrigin, order1.locationDest, order1.createTime,
      order1.departureTime));

  })

  it('modify order', async () => {

    const newStatus = 'PAID';

    await orderManager.createOrder(order1.orderId, order1.orderType, order1.orderStatus,
      order1.feeTotal, order1.passengerAmount, order1.distance,
      order1.locationOrigin, order1.locationDest, order1.createTime,
      order1.departureTime);

    await orderManager.modifyOrder(order1.orderId, newStatus);

    let result = await orderManager.getOrderById(order1.orderId);

    assert.strictEqual(result[0], order1.orderType, "orderType is wrong!");
    assert.strictEqual(result[1], newStatus, "orderStatus is wrong!");
    assert.strictEqual(result[2].toString(), order1.feeTotal, "feeTotal is wrong!");
    assert.strictEqual(result[3].toString(), order1.passengerAmount, "passengerAmount is wrong!");
    assert.strictEqual(result[4].toString(), order1.distance, "distance is wrong!");
    assert.strictEqual(result[5], order1.locationOrigin, "locationOrigin is wrong!");
    assert.strictEqual(result[6], order1.locationDest, "locationDest is wrong!");
    assert.strictEqual(result[7].toString(), order1.createTime, "createTime is wrong!");
    assert.strictEqual(result[8].toString(), order1.departureTime, "departureTime is wrong!");

  })

  it('modify non-exist order', async () => {

    const newStatus = 'PAID';

    await orderManager.createOrder(order1.orderId, order1.orderType, order1.orderStatus,
      order1.feeTotal, order1.passengerAmount, order1.distance,
      order1.locationOrigin, order1.locationDest, order1.createTime,
      order1.departureTime);

    await utils.expectThrow(orderManager.modifyOrder(order2.orderId, newStatus));

  })

  it('query non-exist order', async () => {

    await orderManager.createOrder(order1.orderId, order1.orderType, order1.orderStatus, order1.feeTotal,
      order1.passengerAmount, order1.distance, order1.locationOrigin, order1.locationDest, order1.createTime,
      order1.departureTime);

    result = await orderManager.getOrderById(orders[1].orderId);

    assert.strictEqual(result[0], '', "orderType is wrong!");
    assert.strictEqual(result[1], '', "orderStatus is wrong!");
    assert.strictEqual(result[2].toString(), '0', "feeTotal is wrong!");
    assert.strictEqual(result[3].toString(), '0', "passengerAmount is wrong!");
    assert.strictEqual(result[4].toString(), '0', "distance is wrong!");
    assert.strictEqual(result[5], '', "locationOrigin is wrong!");
    assert.strictEqual(result[6], '', "locationDest is wrong!");
    assert.strictEqual(result[7].toString(), '0', "createTime is wrong!");
    assert.strictEqual(result[8].toString(), '0', "departureTime is wrong!");

  })

})
