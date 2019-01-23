pragma solidity ^0.4.24;
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../contracts/CircuitBreakable.sol";
import "../contracts/oraclizeAPI.sol";

/// @title LibraryDemo - This Dapp maintains employee salary database and calculated bonus
/// @notice Library demo is smartcontract which demos usgae of ethereum packages and Oracle
contract LibraryDemo is Ownable, usingOraclize, CircuitBreakable {

    using SafeMath for uint256;

    uint public electricChargeAllowanceUSD;
    mapping (uint256 => Employee) employees; 
    
    struct Employee {
        uint256 empId;
        uint256  salary;
    }
  
    event LogNewElectricChargePrice(string price);
    event LogNewOraclizeQuery(string description);
    
    constructor() public {
            update(); // First check at contract creation...
        }

    /// @notice  Oraclize query callback where the result of the query is obtained.
    /// @dev Its 2 step process - sending the query and receiving back the result through call back
    ///      and there will be delay in seconds. 
    function __callback(bytes32 myid, string memory result) public {
        require(msg.sender == oraclize_cbAddress());
        emit LogNewElectricChargePrice(result);
        uint256 electricChargePriceUSD = parseInt(result); 
        //Calculate Allowance for 10 Kw/hr/day for 22 working days per month
        electricChargeAllowanceUSD = electricChargePriceUSD.mul(10).mul(22);
        
    }
    /// @notice  Oraclize query is constructed and emitted here
    function update() public payable {
        emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer...");
        oraclize_query("URL", "xml(https://www.fueleconomy.gov/ws/rest/fuelprices).fuelPrices.electric");
    }
  
  
    /// @notice  add employee
    /// @param  _empId Employee Id
    /// @param _salary salary
    /// @return  return successful addition
    function addEmployee(uint256 _empId, uint256 _salary) onlyOwner stopInEmergency public returns(bool) {
        employees[_empId] = Employee({empId:_empId, salary:_salary});
        return true;
    }

    /// @notice calulate the bonus of the employee
    /// @param _empId Employee Id
    /// @param _percent Percentage for calculation
    /// @return return calculated bonus value 
    function calulateBonus(uint256 _empId, uint256 _percent) onlyOwner stopInEmergency public view returns(uint256) {
        require(employees[_empId].salary > 0);
        uint256 bonus = employees[_empId].salary.mul(_percent).div(100);
        return bonus;
    }

    /// @notice Add Calculated electric car allowance to Salary
    /// @param _empId Employee Id
    /// @return return calculated new Salary 
    function addElectriCarAllowanceToSalary(uint256 _empId) onlyOwner stopInEmergency public  returns(uint256) {
        require(employees[_empId].salary > 0);
        employees[_empId].salary = employees[_empId].salary.add(electricChargeAllowanceUSD);
        return employees[_empId].salary;
    }
    
}
  