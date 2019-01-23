pragma solidity ^0.4.24;
import "../contracts/owned.sol";

/// @title Mortal contract ensures self destruction and contract money is refunded to owner
/// @notice This contract inherits the `onlyOwner` modifier
contract mortal is owned {
    // This contract inherits the `onlyOwner` modifier from
    // `owned` and applies it to the `close` function, which
    // causes that calls to `close` only have an effect if
    // they are made by the stored owner.
    function close() public onlyOwner {
        selfdestruct(owner);
    }
}