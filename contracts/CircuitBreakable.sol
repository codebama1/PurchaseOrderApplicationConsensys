pragma solidity ^0.4.24;
import "../contracts/owned.sol";

/// @title Circuit Breakable
/// @notice This contract only defines a modifier but does not use it: it will be used in derived contracts.
contract CircuitBreakable is owned {
    bool private stopped = false;
    function toggleContractActive() onlyOwner public {
        // You can add an additional modifier that restricts stopping a contract to be based on another action, such as a vote of users
        stopped = !stopped;
    }

    modifier stopInEmergency { if (!stopped) _; }
    modifier onlyInEmergency { if (stopped) _; }
}