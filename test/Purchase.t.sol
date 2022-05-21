// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/Purchase.sol";

contract PurchaseTest is Test {
    Purchase escrow;
    address buyer = address(1337);

    function setUp() public {
        escrow = new Purchase();
    }

    function testCompletePurchase() public {
        vm.prank(buyer);
        escrow.confirmPurchase();
        emit log_uint(block.timestamp);

        skip(6 minutes);
        escrow.completePurchase();
    }

    function testCompletePurchaseFailsBeforeDeadline() public {
        vm.prank(buyer);
        escrow.confirmPurchase();

        vm.expectRevert(Purchase.OnlyBuyerOrAfterDeadline.selector);
        escrow.completePurchase();
    }

    receive() external payable {}
}
