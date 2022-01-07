const main = async () => {
    // get info for deploying wallet
    const [deployer] = await hre.ethers.getSigners();
    const accountBalance = await deployer.getBalance();
  
    console.log('Deploying contracts with account: ', deployer.address);
    console.log('Account balance: ', accountBalance.toString());

    // deploy contract  
    const contractFactory = await hre.ethers.getContractFactory('Faucet');
    const contract = await contractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.3"),
    });
    await contract.deployed();
  
    console.log('Faucet contract address: ', contract.address);
};
  
  
const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
};
  
runMain();

// contract address in mainnet as per last deployment: 0x10248C2d057a91b32c842a0AE8bf73b3840206Bc

