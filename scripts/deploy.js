// Deployed at 0x3ebf91879a6922b15E6aae4b23De5D0c2874BEF1

const { ethers } = require("hardhat");

const PROVIDER_ADDRESS = "0x0496275d34753A48320CA58103d5220d394FF77F";

async function main() {
  console.log(`Deploying Contract...`);
  const FlashLoanFactory = await ethers.getContractFactory("FlashLoan");
  const FlashLoan = await FlashLoanFactory.deploy(PROVIDER_ADDRESS);
  await FlashLoan.deployed();
  console.log(`FlashLoan Contract Deployed at ${FlashLoan.address}`);
}

main()
  .then(() => {
    process.exit(0);
  })
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
