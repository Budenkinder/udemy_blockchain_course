
//sometimes not working, result is null, maybe its because of the jvm?
async function getLatestBNumb(){
    web3.eth.getBlockNumber(function(error, result){
                    if(!error){
                        console.log(result);
                    }
                    else
                        console.error(error);
                });
    console.log("BlockNumber: "+result);
}

getLatestBNumb();