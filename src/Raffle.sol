// Layout of the contract file:
// version
// imports
// errors
// interfaces, libraries, contract

// Inside Contract:
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private

// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


/**
 * @author  Peter Ryznar
 * @title   A sample raffle contract
 * @dev     It implements Chainlink VRFv2.5 and Chainlink Automation
 * @notice  This contract is for creating a sample raffle contract
 */

/** Imports */

/** Errors */
error Raffle__NotEnoughEthSent();

contract Raffle {
    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }
    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee, "Not enough ETH sent");
        if(msg.value >= i_entranceFee) revert Raffle__NotEnoughEthSent();
    }

    function pickWinner() public {
        
    }

    /** Getter Functions */
    function getEntranceFee() external view returns(uint256){
        return i_entranceFee;
    }
}