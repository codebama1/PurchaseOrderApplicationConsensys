var PurchaseOrder = artifacts.require("./PurchaseOrder.sol");
var ProxyFactory = artifacts.require("./ProxyFactory.sol");
var owned = artifacts.require("./owned.sol");
var mortal = artifacts.require("./mortal.sol");
module.exports = function(deployer) {
  deployer.deploy(PurchaseOrder);
  deployer.deploy(ProxyFactory);
  deployer.deploy(owned);
  deployer.deploy(mortal);
};
