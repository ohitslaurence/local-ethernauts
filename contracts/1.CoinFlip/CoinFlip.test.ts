import { expect } from "chai";
import { ethers } from "hardhat";
import { helper, helperWithContract } from "./CoinFlipHelper";

let victim: any;
let attacker: any;

describe("Attacking CoinFlip", function () {
  beforeEach(async () => {
    const Victim = await ethers.getContractFactory("CoinFlip");
    victim = await Victim.deploy();
    const Attacker = await ethers.getContractFactory("AttackingCoinFlip");
    attacker = await Attacker.deploy(victim.address);
  });

  it("Succesfully guessess the correct outcome 10 times in a row using ethers", async () => {
    await helper(victim, attacker);
    const consecutiveWins = await victim.consecutiveWins();
    expect(consecutiveWins).to.be.equal(10);
  });

  it("Succesfully guessess the correct outcome 10 times in a row using contract", async () => {
    await helperWithContract(victim, attacker);
    const consecutiveWins = await victim.consecutiveWins();
    expect(consecutiveWins).to.be.equal(10);
  });
});
