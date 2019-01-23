pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/PurchaseOrder.sol";
import "../contracts/ProxyFactory.sol";

contract TestProxyFactory {
  ProxyFactory  proxyFactory = ProxyFactory(DeployedAddresses.ProxyFactory());
  
  // Test whether the Buyer is able to succesfully create the Purchase Order
  function testBuyerCanCreatePurchaseOrder() public {
    proxyFactory.createPOContract();
    proxyFactory.createPOContract();
    address Adidas_buyer = proxyFactory.newPOContracts(0);
    address Adidas_seller = proxyFactory.newPOContracts(1); 
    
    PurchaseOrder purchaseOrder1 = PurchaseOrder(Adidas_buyer);
    bool returnedId = purchaseOrder1.createPurchaseOrder("PO123", "Qmb6vLTkp51HPjQmXCdD97VGyGwr81TNbsQ8ZuodVjikP7", Adidas_seller);
    bool expected = true;
    Assert.equal(returnedId, expected, "PurchaseOrder is not created");
    
  }

  // Test whether the newly created order is in Created state
  function testOrderCreatedWorkflowState() public {

    address Adidas_buyer = proxyFactory.newPOContracts(0);
    PurchaseOrder purchaseOrder1 = PurchaseOrder(Adidas_buyer);
    uint returnedState;
    PurchaseOrder.WorkflowState state = purchaseOrder1.getWorkflowState("PO123");
    if (state == PurchaseOrder.WorkflowState.Created) {
        returnedState = 0;
    }
    Assert.equal(returnedState, 0,"PurchaseOrder is not in Created State");

  }

  // Test whether the Buyer is able to succesfully approve the Purchase Order
  function testBuyerCanApprovePurchaseOrder() public {
    address Adidas_buyer = proxyFactory.newPOContracts(0);
    PurchaseOrder purchaseOrder1 = PurchaseOrder(Adidas_buyer);
    bool returnedId = purchaseOrder1.approvePurchaseOrder("PO123");
    bool expected = true;
    Assert.equal(returnedId, expected, "PurchaseOrder is not Approved");
  }

  // Test whether the newly created order is in Opened state
  function testOrderOpenedWorkflowState() public {

    address Adidas_buyer = proxyFactory.newPOContracts(0);
    PurchaseOrder purchaseOrder1 = PurchaseOrder(Adidas_buyer);
      uint returnedState;
    PurchaseOrder.WorkflowState state = purchaseOrder1.getWorkflowState("PO123");
    if (state == PurchaseOrder.WorkflowState.Opened) {
        returnedState = 1;
    }
    Assert.equal(returnedState, 1,"PurchaseOrder is not in Opened State");
  }

  // Test whether we can fetch the IPFS data from the Order in Contract
  function testfetchingIPFSDatafromOrder() public {

    address Adidas_buyer = proxyFactory.newPOContracts(0);
    PurchaseOrder purchaseOrder1 = PurchaseOrder(Adidas_buyer);
    string memory hash = purchaseOrder1.getIpfsHash("PO123");
    Assert.equal(hash, "Qmb6vLTkp51HPjQmXCdD97VGyGwr81TNbsQ8ZuodVjikP7","IPFS Hash returned is not right.");
  }

  // function testSellerConfirmPurchaseOrder() public {
    
  //   address Adidas_seller = proxyFactory.newPOContracts(1);
  //   PurchaseOrder purchaseOrder2 = PurchaseOrder(Adidas_seller);
  //   bool returnedId = purchaseOrder2.confirmPurchaseOrder("PO123");
  //   bool expected = true;
  //   Assert.equal(returnedId, expected, "PurchaseOrder is not confirmed");
  // }


}
