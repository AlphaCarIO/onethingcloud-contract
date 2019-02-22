var Ownable = artifacts.require("Ownable");
var OrderManager = artifacts.require("OrderManager");

module.exports = function (deployer, network, accounts) {
        if (network == "live") {} else {
                deployer.deploy(OrderManager, accounts[0]);
        }
};
