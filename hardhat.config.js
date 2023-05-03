require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ENDPOINT_URL = process.env.SEPOLIA_URL;

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    sepolia: {
      url: ENDPOINT_URL,
      accounts: [PRIVATE_KEY],
    },
  },
  solidity: "0.8.18",
};
