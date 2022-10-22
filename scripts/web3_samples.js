
//not working, result is null
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
