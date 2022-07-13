// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AlphaToken is ERC20 {
  uint256 initialSupply = 1000000e18;
  constructor() ERC20("AlphaToken", "ATK") {
      _mint(msg.sender, initialSupply);
  }
}
