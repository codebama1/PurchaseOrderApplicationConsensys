pragma solidity ^0.4.24;
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

/// @notice Registry to store PurchaseOrder Contracts.
contract Registry is Ownable {
    address currentPurchaseOrderContract;
    address[] previousPurchaseOrderContracts;

    function changeBackendPurchaseOrder(address newPurchaseOrderContract) public onlyOwner() returns(bool) {
        if(newPurchaseOrderContract != currentPurchaseOrderContract) {
            previousPurchaseOrderContracts.push(currentPurchaseOrderContract);
            currentPurchaseOrderContract = newPurchaseOrderContract;
            return true;
        }
        return false;
    }


}