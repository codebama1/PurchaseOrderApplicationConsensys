
const fs = require('fs');
const mnemonic = fs.readFileSync("../MetaMaskSecret.txt").toString().trim();
var rinkeby_infura = "https://rinkeby.infura.io/v3/8766e7c90fc9467fb6dfaddb8e6f4117";
var ropsten_infura = "https://ropsten.infura.io/v3/8766e7c90fc9467fb6dfaddb8e6f4117";
var HDWalletProvider = require("truffle-hdwallet-provider");
//var mnemonic = "";

module.exports = {
  See <http://truffleframework.com/docs/advanced/configuration>
  for more about customizing your Truffle configuration!
  compilers: {
    solc: {
      version: "0.4.25"
    }
  },
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
      // gasPrice: 1,
      // gas: 6500000,
    },
    rinkeby: {
      provider: new HDWalletProvider(mnemonic, rinkeby_infura),
      network_id: "4",
      gas: 4500000,
    },
    ropsten: {
      provider: new HDWalletProvider(mnemonic, ropsten_infura),
      network_id: "3",
      gas: 5500000,        // Ropsten has a lower block limit than mainnet
      confirmations: 2,    // # of confs to wait between deployments. (default: 0)
      timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: false,
    }
  }
};
