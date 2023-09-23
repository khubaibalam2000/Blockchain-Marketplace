// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract SendReceiveEther {

    // To withdraw ether into the contract
    function withdraw() external payable {}

    // To deposit into amazon account
    function deposit() external {
        address payable _to = payable(0x35D3d2a3321E8746acdba344Fb08280DdE49167c);
        _to.transfer(address(this).balance);
    }
}