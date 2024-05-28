// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import {BaseTest, console2} from "./BaseTest.sol";
import {PlasmaBattleAlphaNFT} from "../src/alpha/PlasmaBattleAlphaNFT.sol";

contract PlasmaBattleAlphaNFTTest is BaseTest {
    PlasmaBattleAlphaNFT internal nft;

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        _setUp();
        nft = new PlasmaBattleAlphaNFT(address(this));
    }

    function test_mint_Success() public {
        nft.mint(address(this));
        assertEq(nft.ownerOf(1), address(this));
        // console2.log(nft.tokenURI(2));
    }
}
