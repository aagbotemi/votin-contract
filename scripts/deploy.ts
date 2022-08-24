import { ethers } from "hardhat";

// CONTRACT ADDRESS: 0x66Ba72a89382dF449F2A868E924735D2dC55A2bD

async function main() {
  const Voting = await ethers.getContractFactory("Voting");
  const voting = await Voting.deploy();

  await voting.deployed();

  console.log(`Voting contract deployed to ${voting.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
