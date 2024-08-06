// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// 多签钱包 接口
interface IWallet {
    // 提交交易
    function submitTransaction(
        address _to,
        uint _value,
        bytes calldata _data
    ) external;

    // 确认交易
    function confirmTransaction(uint _txIndex) external;

    // 执行交易
    function executeTransaction(uint _txIndex) external;

    // 取消确认
    function revokeConfirmation(uint _txIndex) external;

    // 拿取交易数量
    function getTransactionCount() external view returns (uint);

    // 拿取指定数量
    function getTransaction(
        uint _txIndex
    )
        external
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint confirmations
        );
}
