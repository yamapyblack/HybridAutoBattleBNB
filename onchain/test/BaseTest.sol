// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import {console2} from "forge-std/console2.sol";
import {Test} from "forge-std/Test.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";
import {Result} from "../src/core/PlasmaBattle.sol";

contract BaseTest is Test {
    address internal signer;
    uint256 internal signerPrivateKey;

    /// @dev A function invoked before each test case is run.
    function _setUp() public virtual {
        signerPrivateKey = vm.envUint("PRIVATE_KEY");
        signer = vm.addr(signerPrivateKey);
        // console2.log("signer: ", signer);
    }

    function getSignatureBySigner(
        uint _battleId,
        Result _result
    ) internal returns (bytes memory signature_) {
        vm.startPrank(signer);
        bytes32 digest = MessageHashUtils.toEthSignedMessageHash(
            keccak256(abi.encodePacked(_battleId, _result))
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey, digest);
        signature_ = abi.encodePacked(r, s, v); // note the order here is different from line above.
        vm.stopPrank();
    }
}
