// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract WalletTest is Test {
    Wallet public wallet;
    Account signerA = makeAccount("signerA");
    Account signerB = makeAccount("signerB");
    Account signerC = makeAccount("signerC");
    Account other = makeAccount("other");

    function setUp() public {
        address[] memory signerList = new address[](3);
        signerList[0] = signerA.addr;
        signerList[1] = signerB.addr;
        signerList[2] = signerC.addr;
        wallet = new Wallet(signerList, 2);
    }

    function test_WalletTest_submitTransaction_succ() public {
        vm.startPrank(signerA.addr);
        // 假装测试ERC20 的转账
        address _to = 0xd51b4c5483513CF83071fb2E0dF7dbf30c4AC503;
        uint _value = 1;
        bytes memory _data = abi.encodeWithSignature(
            "transfer(to, value)",
            address(wallet),
            2
        );
        uint index = wallet.getTransactionCount();

        vm.expectEmit(true, true, false, false);
        emit SubmitTransaction(signerA.addr, index, _to, _value, _data);

        wallet.submitTransaction(_to, _value, _data);
        vm.stopPrank();
    }

    function test_WalletTest_submitTransaction_fali() public {
        vm.startPrank(other.addr);
        // 假装测试ERC20 的转账
        address _to = 0xd51b4c5483513CF83071fb2E0dF7dbf30c4AC503;
        uint _value = 1;
        bytes memory _data = abi.encodeWithSignature(
            "transfer(to, value)",
            address(wallet),
            2
        );

        vm.expectRevert("Not an owner");
        wallet.submitTransaction(_to, _value, _data);
        vm.stopPrank();
    }

    event SubmitTransaction(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
    );
}
