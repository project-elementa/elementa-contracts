import { ethers, upgrades } from "hardhat";
// 0x5505C56aBd180D13F4bc625B7718b43045425EBb
async function main() {
  const ElementaItem = await ethers.getContractFactory("ElementaItem");

  const elementaItem = await upgrades.deployProxy(ElementaItem, [
    "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
    "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
    "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
    "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
  ]);

  await elementaItem.waitForDeployment();

  console.log("ElementaItem deployed to:", await elementaItem.getAddress());
}
// async function main() {
//   const ElementaNFT = await ethers.getContractFactory("ElementaNFT");

//   const elementaNFT = await upgrades.upgradeProxy(
//     "0x5505C56aBd180D13F4bc625B7718b43045425EBb",
//     ElementaNFT,
//     {}
//   );

//   await elementaNFT.waitForDeployment();

//   console.log("elementaNFT deployed to:", await elementaNFT.getAddress());
// }

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
