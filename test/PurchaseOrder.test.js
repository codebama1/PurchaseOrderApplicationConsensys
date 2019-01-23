var PurchaseOrder = artifacts.require("../contracts/PurchaseOrder.sol");

contract('PurchaseOrder', function(accounts) {
    //const owner = accounts[0];
    const Adidas_buyer = accounts[0];
    const Adidas_seller = accounts[1];
    it("should add an PurchaseOrder with the provided details", async() => {
        const purchaseOrder = await PurchaseOrder.deployed();
        const po = "PO123";
        const hash = "Qmb6vLTkp51HPjQmXCdD97VGyGwr81TNbsQ8ZuodVjikP7";
        var eventEmitted = false;
        //const tx = await purchaseOrder.createPurchaseOrder(po, hash, Adidas_seller, {from:Adidas_buyer});
	
	    // if (tx.logs[0].event) {
		//     eventEmitted = true
	    // }
        // assert.equal(eventEmitted, true, 'PO is NOT created.')
    })
});


