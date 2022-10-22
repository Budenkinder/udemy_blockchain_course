async function getAccounts() {
  console.log('get my accounts');
  const result = await web3.eth.getAccounts();
  console.log(result);
  // expected output: "resolved"
}

async function getLatestBNumb(){
    console.log("Block Number");
    web3.eth.getBlockNumber(function(error, result){
                    if(!error){
                        console.log(result);
                    }
                    else
                        console.error(error);
                });
    console.log(result);
}

getAccounts();
getLatestBNumb();
