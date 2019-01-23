DeployedAddresses Details:

Rinkeby Network:

Pre-setup:
•	Setup your metamask and store the seed words
•	Get ether from rinkeby faucet - https://faucet.rinkeby.io/
•	Setup your Infura third party node and get endpoint
•	Setup the configurations in truffle.js with Infura end point and truffle HD Wallet provider
•	Make sure you received ether in Rinkeby network in metamask
•	Make sure dapp is developed and well tested in testrpc
•	Run the following command from terminal      => truffle migrate --network rinkeby --reset --compile-all
•	Once its successful, check the Rinkeby etherscan


Contract Address: 0xF2aA5f715FedC384F0E00e5670132D9095Da688A
0x87dfcbdf6f7652a1fc47692d9700c85b12fa283c (PurchaseOrder-2nd deployment)


Contract Creation Txn in Rinkeby etherscan:
https://rinkeby.etherscan.io/address/0xf2aa5f715fedc384f0e00e5670132d9095da688a
https://rinkeby.etherscan.io/address/0x87dfcbdf6f7652a1fc47692d9700c85b12fa283c
https://rinkeby.etherscan.io/address/0x1b31bf4962ed72fce63a37ce5106b311d562c6e1

Infura Node: Configured Infura node in truffle.js
"https://rinkeby.infura.io/v3/8766e7c90fc9467fb6dfaddb8e6f4117";


Terminal Command:
$ truffle migrate --network rinkeby --reset --compile-all
Compiling ./contracts/Migrations.sol...
Compiling ./contracts/ProxyFactory.sol...
Compiling ./contracts/PurchaseOrder.sol...
Compiling ./contracts/mortal.sol...
Compiling ./contracts/owned.sol...
Writing artifacts to ./build/contracts

Using network 'rinkeby'.

Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0x2fc5bdd47ffc9443c8ec0bb00ac2f9ca4dc0eb9ec80e45285ac9a7ddfebc03b7
  Migrations: 0xfaae00904d3ee13189a8bfa0e0b67de54844c426
Saving successful migration to network...
  ... 0xa58511b11c55d5166b854a0c84d3c94113edacb5b6634df7dcd78c3d0b92f64d
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying PurchaseOrder...
  ... 0xeb663ba99d61fdd0e0ebbf6e115553471ea84c217c472b8dbdf5e17da81932e5
  PurchaseOrder: 0xf2aa5f715fedc384f0e00e5670132d9095da688a
  Deploying ProxyFactory...
  ... 0x782560cb2aa905095593e0d1b25dc30e18644849cf0bc947b5416c7e3e23749e
  ProxyFactory: 0x581b364ad3e9da94f75021bc745af68500dcf525
Saving successful migration to network...
  ... 0x66a4f79cd744f71dfdff2a90d0a036aeabd422f22f6911735a357174e43f246e
Saving artifacts...
-----------------------------------------------------------------------------------------------------------------------------

$ truffle migrate --network rinkeby --reset --compile-all 
Compiling ./contracts/Migrations.sol...
Compiling ./contracts/ProxyFactory.sol...
Compiling ./contracts/PurchaseOrder.sol...
Compiling ./contracts/mortal.sol...
Compiling ./contracts/owned.sol...
Writing artifacts to ./build/contracts

Using network 'rinkeby'.

Running migration: 1_initial_migration.js
  Replacing Migrations...
  ... 0x02ca5f98ebbca25bf66df1c8ece6404d5aa4899b746e268ff4d246dd01516598
  Migrations: 0xa96260c73c9ec2179afe4afddbe231fe733dcf6d
Saving successful migration to network...
  ... 0x66658848d54fb38041568fbc847291028eed92f9754c90a3699e0b085240f5db
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Replacing PurchaseOrder...
  ... 0x447500699670e17944da96a32ddea2a6c62d623608bdd15ae049513174de5ab7
  PurchaseOrder: 0x87dfcbdf6f7652a1fc47692d9700c85b12fa283c
  Replacing ProxyFactory...
  ... 0x87bab535ba9d191df2fa4d9cbe215087303c5939c0a1658efe8ee4fd516c958c
  ProxyFactory: 0xbcedd9a80b3cd28c038ebe719e52a83ca342c6ce
  Deploying owned...
  ... 0x776db3d4391a600654b973adf52818c4a6977b2e72cdcdc8e149e486ebc07fa1
  owned: 0xd9a0b4c7d7b2957f823753a72e81b6457b6e713d
  Deploying mortal...
  ... 0xc94c6cfd922b3b2a36312f4d879bd8f0d4c081f0c34e36f08943d55c432a1ed7
  mortal: 0xcfca9c7049b7289c49b3c0e98d2af7ae2cd0fb02
Saving successful migration to network...
  ... 0x3cb5a7b58a16b5fccaaea8e92633129ffe7b06050bafa51ef7dc327c35525ce0
Saving artifacts...


