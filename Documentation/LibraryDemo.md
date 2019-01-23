LibraryDemo.sol

•   This Smart contract is written and successfully compiled purely as a way to demonstrate usage of Ethereum packages and usage of Oracle.
•   In the contract, following open-zepplin files are imported and used.

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";

•	In this contract, Oraclize query to obtain standard electric charge price for per KW/hr is used.

•   This is simple contract with 3 functions to add employee and calculate bonus of the employee based on the salary and given percent and compute/add electricCharge allowance to salary of the employee.
•   OnlyOwner of Ownable contract can execute both above functions and uint256 uses safemath for bonus calculation.

•	This contract is circuit breakable, i.e can be stopped during emergencies.
•	This contract also uses Oracle to calculate additional allowance based on electric charge needed  on per day  basis and add it to salary.
•	The electric charge allowance for 10Kw/hr /day for 22 days is given to all employees.


