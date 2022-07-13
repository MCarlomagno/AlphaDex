import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Exchange", () => {
  const deployExchange = async () => {
    const Exchange = await ethers.getContractFactory("Exchange");
    const exchange = await Exchange.deploy();
    return exchange;
  }

  describe("Deployment", function () {
    it("Should contain name", async function () {
      const exchange = await loadFixture(deployExchange);
      const name = await exchange.name();
      expect(name).eq("AlphaDex");
    });
  });
});
