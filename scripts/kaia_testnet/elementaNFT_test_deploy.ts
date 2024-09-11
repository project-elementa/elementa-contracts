import { ethers, upgrades } from "hardhat";
// 0xE40B0EE4Ef5d1DEE1738418Ae3AEe27FD7C808aC
// async function main() {
//   const ElementaNFT = await ethers.getContractFactory("ElementaNFT");

//   const elementaNFT = await upgrades.deployProxy(ElementaNFT, [
//     "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
//     "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
//     "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
//     "0x12920802d981ac6F5A33dA158738756BDb3B1f9B",
//   ]);

//   await elementaNFT.waitForDeployment();

//   console.log("ElementaNFT deployed to:", await elementaNFT.getAddress());
// }

async function main() {
  const ElementaNFT = await ethers.getContractFactory("ElementaNFT");

  const elementaNFT = await upgrades.upgradeProxy(
    "0xE40B0EE4Ef5d1DEE1738418Ae3AEe27FD7C808aC",
    ElementaNFT,
    {}
  );

  await elementaNFT.waitForDeployment();

  console.log("elementaNFT deployed to:", await elementaNFT.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
