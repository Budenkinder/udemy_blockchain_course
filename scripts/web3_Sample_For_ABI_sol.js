//
async function interactWithABI(){
    const address ="0xd9145CCE52D386f254917e481eB44e9943F39138";
const abiArray = [
	{
		"inputs": [],
		"name": "myUint",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newUint",
				"type": "uint256"
			}
		],
		"name": "setMyUint",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

    const contractInstance = new web3.eth.Contract(abiArray, address);
    //this is a read function
    console.log(await contractInstance.methods.myUint().call());
    //here we want to overwrite it and like on remix, an account is editing.
    console.log(await contractInstance.methods.setMyUint(125).send({from:"0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"}));
    console.log(await contractInstance.methods.myUint().call());
}

interactWithABI();