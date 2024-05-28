// SPDX-License-Identifier: MIT
pragma solidity >=0.8.23 <0.9.0;

import {BaseScript} from "./Base.s.sol";
import {PlasmaBattleAlpha} from "../src/alpha/PlasmaBattleAlpha.sol";
import {PlasmaBattleAlphaNFT} from "../src/alpha/PlasmaBattleAlphaNFT.sol";
import {console2} from "forge-std/console2.sol";

contract PlasmaBattleAlphaScript is BaseScript {
    function run() public broadcast {
        PlasmaBattleAlpha c = new PlasmaBattleAlpha(deployer);
        console2.log("PlasmaBattleAlpha:", address(c));
        PlasmaBattleAlphaNFT nft = new PlasmaBattleAlphaNFT(address(c));
        console2.log("PlasmaBattleAlphaNFT:", address(nft));
        c.setNftAddress(address(nft));
    }
}
