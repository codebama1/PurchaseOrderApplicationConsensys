pragma solidity ^0.4.24;


/// @title Owned Contract
/// @notice This contract only defines a modifier but does not use it: it will be used in derived contracts.
contract owned {
    constructor() public { owner = msg.sender; }
    address public owner;

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can call this function."
        );
        _;
    }
}
