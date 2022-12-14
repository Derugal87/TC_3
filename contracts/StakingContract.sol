// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakingContract is ERC20 {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public profits;

    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * (10 ** uint(decimals())));
    }

    function depositStake(uint256 _stake) public payable {
        require(_stake > 0, "Stake must be greater than 0");
        require(msg.value >= _stake, "Insufficient funds to deposit stake");
        stakes[msg.sender] += _stake;
    }

    function withdrawStake(uint256 _stake) public payable {
        require(stakes[msg.sender] >= _stake, "Insufficient stake");
        stakes[msg.sender] -= _stake;
        msg.sender.transfer(address[msg.sender], _stake + profits[msg.sender]);
        profits[msg.sender] = 0;
    }

    function calculateProfit(address _staker) public {
        uint256 profit = stakes[_staker] * 0.05;
        profits[_staker] += profit;
    }
}

