// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "script/Interactions.s.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle, HelperConfig){
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        
        if(config.subscriptionId == 0){
            CreateSubscription createSubscription = new CreateSubscription();
            (config.subscriptionId, config.vrfCoordinator) = createSubscription.createSubscription(config.vrfCoordinator);
        
            // Fund it!
            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(config.vrfCoordinator, config.subscriptionId, config.link);
        }

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
        
        AddConsumer addConsumer = new AddConsumer();
        addConsumer.addConsumer(address(raffle), config.vrfCoordinator, config.subscriptionId);

        return (raffle, helperConfig);

    }
}



