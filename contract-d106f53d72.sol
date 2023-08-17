// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.9.3/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.3/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.9.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.3/utils/math/SafeMath.sol";

contract ServiToken is ERC20, ERC20Burnable, Ownable {
    using SafeMath for uint256;

    uint256 private constant BURN_RATE = 5; // 0.5%
    uint256 private constant BURN_BASE = 1000;

    constructor() ERC20("Servi Token", "SRVP") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override {
        uint256 burnAmount = amount.mul(BURN_RATE).div(BURN_BASE);
        uint256 transferAmount = amount.sub(burnAmount);

        super._transfer(sender, recipient, transferAmount);

        if (burnAmount > 0) {
            _burn(sender, burnAmount);
        }
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
