// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle, HelperConfig){
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        
        vm.startBroadcast();
        Raffle raffle = new Raffle(
        config.subscriptionId,
        config.gasLane,
        config.interval,
        config.entranceFee,
        config.callbackGasLimit,
        config.vrfCoordinator
        );
        vm.stopBroadcast();
        
        return (raffle, helperConfig);

    }
}



