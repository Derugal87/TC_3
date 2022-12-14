const hre = require("hardhat");

async function main() {
  const StakingContract = await hre.ethers.getContractFactory("StakingContract");
  const stakingContract = await StakingContract.deploy();
  await stakingContract.deployed();

  console.log("My Token", stakingContract.address);

}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
