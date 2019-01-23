unresolvedIssues.md

uport Integration:
•	It is really simple to connect to uport – simple signer javascript code addition, and then you will be able to sign txns from uport mobile app.
•	The problem is am not able to load rinkeby test ethers to my uport ethereum rinekby account address.
•	Though the Txn seems successful, the ethereum  address balance is still “0”
•	I tried transferring from metamamsk account, rinkeby faucets, but in vain.
https://rinkeby.etherscan.io/address/0xaa134652155eed5391bf2c7977f149a7f04ab668

•	So am not able to successfully create app. To try with other ethereum addresses, I have to wait for another 3 days to get test ether according to faucet.rinkeby.io.
•	Hence have to skip uport integration.

Ropsten Deployment:
•	Ropsten deployment is not successful, because truffle always takes the first account from metamask rather than current Ropsten account with few ropsetn ethers.
•	Running dry run shows the issue as current account having 0 ethers, though it has 5 ethers. It looks truffle takes first account rather current account.
•	$ truffle migrate --network ropsten --reset --compile-all --dry-run
•	Compiling ./contracts/LibraryDemo.sol...
•	Compiling ./contracts/Migrations.sol...
•	Compiling ./contracts/ProxyFactory.sol...
•	Compiling ./contracts/PurchaseOrder.sol...
•	Compiling ./contracts/mortal.sol...
•	Compiling ./contracts/owned.sol...
•	Compiling zeppelin-solidity/contracts/math/SafeMath.sol...
•	Compiling zeppelin-solidity/contracts/ownership/Ownable.sol...
•	Writing artifacts to ./build/contracts
•	
•	Using network 'ropsten' (dry run).
•	
•	Running migration: 1_initial_migration.js
•	  Deploying Migrations...
•	Error encountered, bailing. Network state unknown. Review successful transactions manually.
•	sender doesn't have enough funds to send tx. The upfront cost is: 672197500000000000 and the sender's account only has: 0



