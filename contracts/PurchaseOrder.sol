pragma solidity ^0.4.24;
import "../contracts/mortal.sol";
import "../contracts/CircuitBreakable.sol";
import "../contracts/Registry.sol";

/// @title PurchaseOrder Contract 
/// @notice Creates/modifies PurchaseOrder and maintains workflow state of PO in supplyChain

contract PurchaseOrder is mortal, CircuitBreakable, Registry {

    //State Variables
    mapping (string => Order) orders;
    enum WorkflowState { Created, Opened, Confirmed, Declined }
    
    //Data structure to hold most important purchase order details on Ethereum
    struct Order {
      string poNumber; //Key should be unique
      string ipfsHash; //IPFS hash data of PO document
      WorkflowState state;
      address seller;
      address buyer;
  } 

    //
    // Events - publicize actions to external listeners
    //
  
    event LogPurchaseOrderCreated(string indexed poNumber);
    event LogPurchaseOrderApproved(string indexed poNumber);
    event LogPurchaseOrderConfirmed(string indexed poNumber);
    event LogPurchaseOrderDeclined(string indexed poNumber);
    
    //modifiers
    modifier onlyOwner() { require(msg.sender == owner, "The msg.sender must be contract's owner!");_;}
    modifier isCallerSeller(string _poNumber) { require (msg.sender == orders[_poNumber].seller); _;}
    modifier isCallerBuyer(string _poNumber) { require (msg.sender == orders[_poNumber].buyer); _;}
    modifier isCallerBuyerOrSeller(string _poNumber) { require (msg.sender == orders[_poNumber].seller || msg.sender == orders[_poNumber].buyer); _;}
    modifier opened(string _poNumber) {
      require(WorkflowState.Opened == orders[_poNumber].state, "This items state must be in Opened state!");
      _;
    }
    modifier created(string _poNumber) {
        require(WorkflowState.Created == orders[_poNumber].state, "This items state must be in Created state!");
        _;
    }
  
  /// @notice create the PO
  /// @dev The function which creates purchase order can be used to modify PO as well
  /// @param _poNumber Key holding the mapping of Order to OrderDetails
  /// @param _ipfsHash IPFS hash data that stores entire PO document
  /// @return true if successful

  function createPurchaseOrder(string _poNumber, string _ipfsHash, address _seller) stopInEmergency public returns(bool) {
    orders[_poNumber] = Order({poNumber: _poNumber, ipfsHash: _ipfsHash, state: WorkflowState.Created, seller: _seller, buyer :msg.sender});
    emit LogPurchaseOrderCreated(_poNumber);
    return true;
  }

  /// @notice confirm the PO - Only buyer can approve PO / PO should be in CREATED state before approval
  /// @param _poNumber Key holding the mapping of Order to OrderDetails
  /// @return true if successful

  function approvePurchaseOrder(string _poNumber) created(_poNumber) isCallerBuyer(_poNumber) stopInEmergency public returns(bool) {
    orders[_poNumber].state = WorkflowState.Opened;
    emit LogPurchaseOrderApproved(_poNumber);
    return true;
  }

  /// @notice confirm the PO - Only seller can confirm PO / PO should be in OPENED state before confirmation
  /// @param _poNumber Key holding the mapping of Order to OrderDetails
  /// @return true if successful

  function confirmPurchaseOrder(string _poNumber) opened(_poNumber) isCallerSeller(_poNumber) stopInEmergency public returns(bool) {
    orders[_poNumber].state = WorkflowState.Confirmed;
    emit LogPurchaseOrderConfirmed(_poNumber);
    return true;
  }

  /// @notice decline the PO - Only seller can decline PO / PO should be in OPENED state before Declining
  /// @param _poNumber Key holding the mapping of Order to OrderDetails
  /// @return true if successful
  
  function declinePurchaseOrder(string _poNumber) opened(_poNumber) isCallerSeller(_poNumber) stopInEmergency public returns(bool) {
    orders[_poNumber].state = WorkflowState.Declined;
    emit LogPurchaseOrderDeclined(_poNumber);
    return true;
  }

  /// @notice Gets IPFSHash of the PO Details
  /// @param _poNumber Key holding the mapping of Order to OrderDetails
  /// @return string ipfsHash

  function getIpfsHash(string _poNumber) isCallerBuyerOrSeller(_poNumber) public view returns(string) {
    return orders[_poNumber].ipfsHash;
  }

  /// @notice Gets WorkflowState of the PO Details
  /// @param _poNumber Key holding the mapping of Order to OrderDetails
  /// @return WorkflowState 
  function getWorkflowState(string _poNumber) isCallerBuyerOrSeller(_poNumber) public view returns(WorkflowState) {
    return orders[_poNumber].state;
  }

  /// @notice Gets WorkflowState, Buyer, Seller of the PO Details
  /// @param _poNumber Key holding the mapping of Order to OrderDetails
  /// @return WorkflowState ,Buyer, Seller
  function getOrderStateBuyerSeller(string _poNumber) isCallerBuyerOrSeller(_poNumber) public view returns(WorkflowState, address, address) {
    return (orders[_poNumber].state, orders[_poNumber].buyer, orders[_poNumber].seller);
  }


  
}

