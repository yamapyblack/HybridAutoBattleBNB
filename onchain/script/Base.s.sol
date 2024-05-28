// SPDX-License-Identifier: MIT
pragma solidity >=0.8.23 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";

abstract contract BaseScript is Script {
    uint256 internal deployerPrivateKey;
    address public deployer;

    constructor() {
        deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        deployer = vm.addr(deployerPrivateKey);
    }

    modifier broadcast() {
        // string memory url = vm.rpcUrl("scroll");
        // console2.log("url:", url);

        vm.startBroadcast(deployerPrivateKey);
        _;
        vm.stopBroadcast();
    }
}
