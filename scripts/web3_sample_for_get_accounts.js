async function getAccounts() {
  console.log('get my accounts now');
  const result = await web3.eth.getAccounts();
  console.log(result);
  // expected output: "resolved"
}

getAccounts();