// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract TokenExchange {
    IERC20 public tokenA;
    IERC20 public tokenB;
    address public owner;

    constructor(IERC20 _tokenA, IERC20 _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        owner = msg.sender;
    }

    function depositA(uint amountA) external {
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "Transfer failed");
    }

    function depositB(uint amountB) external {
        require(tokenB.transferFrom(msg.sender, address(this), amountB), "Transfer failed");
    }

    function exchangeAToB(uint amountA) external {
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "Transfer failed");
        uint amountB = amountA;
        require(tokenB.transfer(msg.sender, amountB), "Transfer failed");
    }

    function exchangeBToA(uint amountB) external {
        require(tokenB.transferFrom(msg.sender, address(this), amountB), "Transfer failed");
        uint amountA = amountB;
        require(tokenA.transfer(msg.sender, amountA), "Transfer failed");
    }
}
