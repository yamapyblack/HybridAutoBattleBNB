// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import {BaseTest, console2} from "./BaseTest.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

import {Result} from "../src/core/PlasmaBattle.sol";
import {PlasmaBattleAlpha, PlasmaBattleAlphaMock} from "../src/mocks/PlasmaBattleAlphaMock.sol";
import {PlasmaBattleAlphaNFT} from "../src/alpha/PlasmaBattleAlphaNFT.sol";

contract PlasmaBattleAlphaTest is BaseTest {
    PlasmaBattleAlphaMock internal alpha;

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        _setUp();
        alpha = new PlasmaBattleAlphaMock(signer);
    }

    function _assertPlayerUnits(uint[5] memory _playerUnits) internal view {
        uint[5] memory playerUnits_ = alpha.getPlayerUnits(address(this));
        for (uint i = 0; i < 5; i++) {
            // console2.log("playerUnits_[i]: ", playerUnits_[i]);
            assertEq(playerUnits_[i], _playerUnits[i]);
        }
    }

    function _assertSubUnits(uint[5] memory _subUnits) internal view {
        uint[5] memory subUnits_ = alpha.getSubUnits(address(this));
        for (uint i = 0; i < 5; i++) {
            // console2.log("subUnits_[i]: ", subUnits_[i]);
            assertEq(subUnits_[i], _subUnits[i]);
        }
    }

    function test_startBattle_Success() public {
        uint[5] memory _playerUnits = [uint(1), 0, 0, 0, 0];
        uint[5] memory _subUnits = [uint(0), 0, 0, 0, 0];

        alpha.startBattle(_playerUnits, _subUnits);
        (address _player, , , ) = alpha.battleRecord(1);
        assertEq(_player, address(this));
        _assertPlayerUnits(_playerUnits);
    }

    //TODO revive this test
    // function test_startBattle_Fail1() public {
    //     uint[5] memory _playerUnits = [uint(2), 0, 0, 0, 0];
    //     uint[5] memory _subUnits = [uint(0), 0, 0, 0, 0];

    //     vm.expectRevert(PlasmaBattleAlpha.InvalidUnitId.selector);
    //     alpha.startBattle(_playerUnits, _subUnits);
    // }

    function test_endBattle_Success() public {
        uint[5] memory _playerUnits = [uint(1), 0, 0, 0, 0];
        uint[5] memory _subUnits = [uint(0), 0, 0, 0, 0];

        alpha.startBattle(_playerUnits, _subUnits);
        Result _result = Result.WIN;
        bytes memory _signature = getSignatureBySigner(1, _result);
        alpha.endBattle(1, _result, _signature);
        assertEq(alpha.playerStage(address(this)), 1);
        _assertPlayerUnits(_playerUnits);
        uint[5] memory _subUnits2 = [uint(4), 0, 0, 0, 0];
        _assertSubUnits(_subUnits2);
    }

    function test_validateUnits_Fail1() public view {
        uint[5] memory _playerUnits = [uint(2), 0, 0, 0, 0];
        uint[5] memory _subUnits = [uint(0), 0, 0, 0, 0];
        assertEq(alpha.validateUnits(0, _playerUnits, _subUnits), false);
    }

    function test_validateUnits_Fail2() public view {
        uint[5] memory _playerUnits = [uint(1), 1, 0, 0, 0];
        uint[5] memory _subUnits = [uint(0), 0, 0, 0, 0];
        assertEq(alpha.validateUnits(0, _playerUnits, _subUnits), false);
    }

    function test_validateUnits_Fail3() public view {
        uint[5] memory _playerUnits = [uint(1), 0, 0, 0, 0];
        uint[5] memory _subUnits = [uint(1), 0, 0, 0, 0];
        assertEq(alpha.validateUnits(0, _playerUnits, _subUnits), false);
    }

    function test_battleEndMint_Success() public {
        //Deploy NFT
        PlasmaBattleAlphaNFT nft = new PlasmaBattleAlphaNFT(address(alpha));
        alpha.setNftAddress(address(nft));

        uint[5] memory _playerUnits = [uint(1), 0, 0, 0, 0];
        uint[5] memory _subUnits = [uint(0), 0, 0, 0, 0];

        alpha.startBattle(_playerUnits, _subUnits);
        Result _result = Result.WIN;
        bytes memory _signature = getSignatureBySigner(1, _result);
        alpha.endBattle(1, _result, _signature);

        //Battle 2
        alpha.startBattle(_playerUnits, _subUnits);
        _signature = getSignatureBySigner(2, _result);
        alpha.endBattle(2, _result, _signature);
        //Battle 3 (mint)
        alpha.startBattle(_playerUnits, _subUnits);
        _signature = getSignatureBySigner(3, _result);
        alpha.endBattle(3, _result, _signature);

        assertEq(nft.ownerOf(1), address(this));
    }
}
