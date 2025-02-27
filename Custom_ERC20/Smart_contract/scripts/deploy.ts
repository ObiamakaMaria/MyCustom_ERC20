import { ethers } from "hardhat";


async function main() {
    const signer = await ethers.provider.getSigner();

    console.log(" AMAKSNFT Contract Deployer's Address: ", signer.address)

    const amaks_token = await ethers.deployContract("AMAKSNFT", ["AMAKS_TOKEN", "AMAKS"])
    await amaks_token.waitForDeployment()

    console.log(" AMAKSNFT Contract Deployed ")
    console.log("Contract Address: ", amaks_token.target)


}

main().catch((error) => {
    console.error(error)
    process.exit(1)
})