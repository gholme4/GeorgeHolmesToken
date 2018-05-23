pragma solidity ^0.4.0;

interface ERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint balance);
    function transfer(address to, uint  value) external returns (bool success);
    function transferFrom(address from, address to, uint value) external returns (bool success);
    function approve(address spender, uint value) external returns (bool success);
    function allowance(address owner, address spender) external view returns (uint remaining);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}