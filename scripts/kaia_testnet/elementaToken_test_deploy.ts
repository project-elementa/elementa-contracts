import { ethers, upgrades } from "hardhat";
// 0x4B16f003562dcdEa061C8a2b58CCA7fAa5978271
// async function main() {
//   const ElementaToken = await ethers.getContractFactory("ElementaToken");

//   const elementaToken = await upgrades.deployProxy(ElementaToken, [
//     "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
//   ]);

//   await elementaToken.waitForDeployment();

//   console.log("ElementaToken deployed to:", await elementaToken.getAddress());
// }
async function main() {
  const ElementaToken = await ethers.getContractFactory("ElementaToken");

  const elementaToken = await upgrades.upgradeProxy(
    "0x4B16f003562dcdEa061C8a2b58CCA7fAa5978271",
    ElementaToken,
    {}
  );

  await elementaToken.waitForDeployment();

  console.log("ElementaToken deployed to:", await elementaToken.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
