import { ethers } from "hardhat";


async function main() {
    
    const AmaksNFT = await ethers.getContractFactory("AmaksNFT");
    const Amaks_NFT = await AmaksNFT.deploy();
    await Amaks_NFT.waitForDeployment();

    console.log("AmaksNFT Deployed to  to:", await Amaks_NFT.getAddress());

   
    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    }); 

    
