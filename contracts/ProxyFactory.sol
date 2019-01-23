pragma solidity ^0.4.24;
import "../contracts/PurchaseOrder.sol";

contract ProxyFactory {
    address[] public newPOContracts;

    function createPOContract() public {
        address newPOContract = new PurchaseOrder();
        newPOContracts.push(newPOContract);
        
    } 
}