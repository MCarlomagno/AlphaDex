// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import './AlphaToken.sol';

contract Exchange {
    string public name = "AlphaDex";

    mapping(string => IERC20) tokens;

    event Bought(uint256 amount);
    event Sold(uint256 amount);

    constructor() {
        tokens["ATK"] = new AlphaToken();
    }

    function buy(string calldata ticker) payable public {
        IERC20 token = tokens[ticker];
        require(token.totalSupply() > 0, "Token not supported");

        uint256 amount = msg.value;
        uint256 balance = token.balanceOf(address(this));

        require(amount > 0, "The amount to buy must be greater than 0");
        require(amount <= balance, "Not enough tokens in the reserve");

        token.transfer(msg.sender, amount);
        emit Bought(amount);
    }

    function sell(string calldata ticker, uint256 amount) public {
        require(amount > 0, "The amount to sell must be greater than 0");
        
        IERC20 token = tokens[ticker];
        require(token.totalSupply() > 0, "Token not supported");

        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= amount, "Not allowed to sell that amount of tokens");

        token.transferFrom(msg.sender, address(this), amount);
        payable(msg.sender).transfer(amount);
        emit Sold(amount);
    }
}
