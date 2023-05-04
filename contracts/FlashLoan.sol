// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract FlashLoan is FlashLoanSimpleReceiverBase {
    address payable private immutable owner;

    constructor(
        address _addressProvider
    ) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider)) {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "OWNER_ERROR");
        _;
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address /*initiator*/,
        bytes calldata /*params*/
    ) external override returns (bool) {
        // Our Custom Logic here
        //
        //

        uint256 amountOwed = amount + premium;
        IERC20(asset).approve(address(POOL), amountOwed);
        return true;
    }

    function requestFlashLoan(address asset, uint256 amount) public {
        POOL.flashLoanSimple(address(this), asset, amount, "", 0);
    }

    function getBalance(address asset) public view returns (uint256) {
        uint256 balance = IERC20(asset).balanceOf(address(this));
        return balance;
    }

    function withdraw(address asset) external onlyOwner {
        uint256 balance = getBalance(asset);
        require(balance > 0, "INSUFFICIENT_FUNDS");
        bool sent = IERC20(asset).transfer(owner, balance);
        require(sent, "TRANSFER_FAILED");
    }

    receive() external payable {}

    fallback() external payable {}
}
