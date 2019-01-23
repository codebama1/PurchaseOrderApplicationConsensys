import React, { Component } from 'react';
import './App.css';
import web3 from './web3';
import ipfs from './ipfs';
import storeMyValue from './storeMyValue';
class App extends Component {
state = {
    poNumber:'',
    itemName:'',
    itemCount:'',
    uintPrice:'',
    incoterm:'',
    destination:'',
    seller:'',
    ipfsHash:null,
    buffer:'',
    queryPoNumber:'',
    queryIpfsHash:'',
    queryIpfsHashData:'',
    queryWorkflowState:'',
    buyer:'',
    querySeller:'',
    ethAddress:''
   
};

readIpfsHash = async(ipfsHash) => {
   console.log("incoming ipfshash is", ipfsHash);
    const bufferOriginal = await ipfs.cat(ipfsHash);
    this.state.queryIpfsHashData = bufferOriginal.toString('utf8');
    console.log(this.state.queryIpfsHashData)
    
};

onPOSubmit = async(event) => {
    event.stopPropagation()
    event.preventDefault()
    const accounts = await web3.eth.getAccounts();
    this.setState({ethAddress:accounts[0]})
    console.log(this.state.poNumber);
    console.log(this.state.itemName);
    console.log(this.state.seller);
    var hashData = this.state.poNumber.concat(" ", this.state.itemName," ",
    this.state.itemCount, " ",this.state.unitPrice, " ",this.state.incoterm, " ",this.state.destination);
    const buffer = await Buffer.from(hashData);
    console.log(buffer);
    await ipfs.add(buffer, (err, ipfsHash) => {
        console.log(err,ipfsHash);
        this.setState({ ipfsHash:ipfsHash[0].hash });
        console.log(this.state.ipfsHash);
        storeMyValue.methods.createPurchaseOrder(this.state.poNumber, this.state.ipfsHash, this.state.seller).send({
        from: accounts[0]
        }, (error, transactionHash) => {
        console.log("transaction hash is ",transactionHash);
        });
    })
    
}//onPOSubmit

onQueryPOSubmit = async(event) => {
    event.stopPropagation();
    event.preventDefault();
    const accounts = await web3.eth.getAccounts();
    console.log(accounts[0]);
    this.setState({ethAddress:accounts[0]});

    storeMyValue.methods.getOrderStateBuyerSeller(this.state.queryPoNumber).call({from:accounts[0]}).then(
        (value) => { 
                console.log("value is",value);
                if (value[0] == 0) {
                    this.setState({queryWorkflowState : "CREATED"});
                    console.log("result is",this.state.queryWorkflowState,"&&&");
                } else if (value[0] == 1) {
                    this.setState({queryWorkflowState : "OPENED"});
                    console.log("result is",this.state.queryWorkflowState,"&&&");
                } else if (value[0] == 2) {
                    this.setState({queryWorkflowState : "CONFIRMED"});
                    console.log("result is",this.state.queryWorkflowState,"&&&");
                } else if (value[0] == 3) {
                    this.setState({queryWorkflowState : "DECLINED"});
                    console.log("result is",this.state.queryWorkflowState,"&&&");
                }
                this.setState({buyer : value[1]});
                this.setState({querySeller : value[2]});
        });
  
    // storeMyValue.methods.getWorkflowState(this.state.queryPoNumber).call().then(
    //     (value) => { 
    //             console.log("result is",value);
    //             if (value == 0) {
    //                 this.setState({queryWorkflowState : "OPENED"});
    //                 console.log("result is",this.state.queryWorkflowState,"&&&");
    //             } else if (value == 1) {
    //                 this.setState({queryWorkflowState : "CONFIRMED"});
    //                 console.log("result is",this.state.queryWorkflowState,"&&&");
    //             } else if (value == 2) {
    //                 this.setState({queryWorkflowState : "DECLINED"});
    //                 console.log("result is",this.state.queryWorkflowState,"&&&");
    //             }
    //     });
    
   

}//onQueryPOSubmit

onApprove = async(event) => {
    event.stopPropagation()
    event.preventDefault()
    const accounts = await web3.eth.getAccounts();
    this.setState({ethAddress:accounts[0]});
    console.log(this.state.queryPoNumber)
    storeMyValue.methods.approvePurchaseOrder(this.state.queryPoNumber).send({
        from: accounts[0]
        }, (error, transactionHash) => {
        console.log("transaction hash is ",transactionHash);
        });

}//OnApprove

onConfirm = async(event) => {
    event.stopPropagation()
    event.preventDefault()
    const accounts = await web3.eth.getAccounts();
    this.setState({ethAddress:accounts[0]});
    console.log(this.state.queryPoNumber)
    storeMyValue.methods.confirmPurchaseOrder(this.state.queryPoNumber).send({
        from: accounts[0]
        }, (error, transactionHash) => {
        console.log("transaction hash is ",transactionHash);
        });

}//OnConfirm

onDecline = async(event) => {
    event.stopPropagation()
    event.preventDefault()
    const accounts = await web3.eth.getAccounts();
    this.setState({ethAddress:accounts[0]});
    console.log(this.state.queryPoNumber)
    storeMyValue.methods.declinePurchaseOrder(this.state.queryPoNumber).send({
        from: accounts[0]
        }, (error, transactionHash) => {
        console.log("transaction hash is ",transactionHash);
        });

}//OnDecline

poNumberHandler = async(event) => {
    if (event.target.value.length > 1) {
        this.state.poNumber = event.target.value;
        const accounts = await web3.eth.getAccounts();
        console.log(accounts[0]);
        this.setState({ethAddress:accounts[0]});
    }
}

itemNameHandler = event => {
    this.state.itemName = event.target.value;
}
itemCountHandler = event => {
    this.state.itemCount = event.target.value;
}
unitPriceHandler = event => {
    this.state.unitPrice = event.target.value;
}
incotermHandler = event => {
    this.state.incoterm = event.target.value;
}
destinationHandler = event => {
    this.state.destination = event.target.value;
}
sellerHandler = event => {
    this.state.seller = event.target.value;
}

queryPoNumberHandler = async(event) => {
    if (event.target.value.length > 1) {
        this.state.queryPoNumber = event.target.value;
        const accounts = await web3.eth.getAccounts();
        console.log(accounts[0]);
        this.setState({ethAddress:accounts[0]});
        storeMyValue.methods.getIpfsHash(this.state.queryPoNumber).call({from:accounts[0]}).then(
            (queryIpfsHash) => { 
                console.log("result is ",queryIpfsHash);
                this.setState({queryIpfsHash});
                this.readIpfsHash(this.state.queryIpfsHash);

            }).catch(function(err) {
                console.log(err.message);
               
              });
    }
}

render() {
return (
<div className="App">
<header className="App-header">
<h1> Purchase Order Application</h1>
</header>
<hr/>
Current Ethereum Address : {this.state.ethAddress} <br/>
<hr/>
<h3>Buyer</h3>
<form  onSubmit={this.onPOSubmit}>
 PO Number: 
 <input type="text" name="PONumber" onChange={this.poNumberHandler}/> <br/>
 Item Name: 
 <input type="text" name="ItemName"  onChange={this.itemNameHandler}/> <br/>
 Seller: 
 <input type="text" name="Seller"  onChange={this.sellerHandler}/> <br/>
 Item Count: 
 <input type="text" name="ItemCount"  onChange={this.itemCountHandler}/> <br/>
 Unit Price: 
 <input type="text" name="UnitPrice"  onChange={this.unitPriceHandler}/> <br/>
 Incoterm: 
 <input type="text" name="Incoterm"  onChange={this.incotermHandler}/> <br/>
 Destination: 
 <input type="text" name="Destination"  onChange={this.destinationHandler}/> <br/>
 <br/>
 <button type="submit"> Submit Application </button>
 </form>
 <br/> Created PO's IPFS Hash : {this.state.ipfsHash} <br/> <br/>
 <hr/>
 <h3>Buyer & Seller</h3>
 <form onSubmit={this.onQueryPOSubmit}>
<input type="text" name="queryPONumber" onChange={this.queryPoNumberHandler}/>
<button type="submit"> Show Order from IPFS & State from Ethereum </button>
</form>
<table>
                <thead>
                  <tr>
                    <th>Workflow State</th>
                    <th>Order Details</th>
                    <th>Buyer</th>
                    <th>Seller</th>
                  </tr>
                </thead>
               
                <tbody>
                  <tr>
                    <td>{this.state.queryWorkflowState}</td>
                    <td>{this.state.queryIpfsHashData}</td>
                    <td>{this.state.buyer}</td>
                    <td>{this.state.querySeller}</td>
                  </tr>
                
                </tbody>
            </table>

Buyer:
<button onClick = {this.onApprove}>Approve</button>
Seller:
<button onClick = {this.onConfirm}>Confirm</button>
<button onClick= {this.onDecline}>Decline</button> <br/> <br/>
<hr/>

</div>);
}
}
export default App;
