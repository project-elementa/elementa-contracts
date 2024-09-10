// SPDX-License-Identifier: UNLICENSED

interface IPayment {
    function stakeFor(address recipient) external payable;
    function reFund(
        address _sender,
        uint _reFundAmount
    ) external returns (uint, uint);
}
