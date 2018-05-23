pragma solidity ^0.4.0;

import "./ERC20.sol";
import "./ERC223.sol";
import "./ERC223ReceivingContract.sol";

contract GeorgeHolmesToken is ERC20, ERC223  {
    string public constant symbol = "GHT";
    string public constant name = "George Holmes Token";
    uint8 public constant decimals = 18;
    address private _owner;
    
    uint private constant _totalSupply = 10000;
    
    mapping (address => uint) private _balanceOf;
    mapping (address => mapping (address => uint)) private _allowances;
    
    constructor() public {
            _balanceOf[msg.sender] = _totalSupply;
            _owner = msg.sender;
    }
    
    function totalSupply() external view returns (uint) {
        return _totalSupply;
    }
    
    function balanceOf(address addr) external view returns (uint) {
        return _balanceOf[addr];
    }
    
    function transfer(address to, uint value) external returns (bool) {
        if (value > 0 && 
            value <= _balanceOf[msg.sender] && 
            !isContract(to)) {

            _balanceOf[msg.sender] -= value;
            _balanceOf[to] += value;
            
            emit Transfer(msg.sender, to, value);
            return true;
        }
        return false;
    }
    
    function transfer(address to, uint value, bytes data) external returns (bool) {
        if (value > 0 && 
            value <= _balanceOf[msg.sender] && 
            isContract(to)) {

            _balanceOf[msg.sender] -= value;
            _balanceOf[to] += value;
            ERC223ReceivingContract _contract = ERC223ReceivingContract(to);
            _contract.tokenFallback(msg.sender, value, data);
            emit Transfer(msg.sender, to, value, data);

            return true;
        }
        return false;
    }

     function isContract(address addr) internal view returns (bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(addr)
        }
        
        return codeSize > 0;
    }
    
    function transferFrom(address from, address to, uint value) external returns (bool) {
        if (_allowances[from][msg.sender] > 0 &&
            value > 0 &&
            _allowances[from][msg.sender] >= value && 
            _balanceOf[from] >= value) {

            _balanceOf[from] -= value;
            _balanceOf[to] += value;
            
            _allowances[from][msg.sender] -= value;
            return true;
        }

        return false;
    }
    
    function approve(address spender, uint value) external returns (bool) {
        if (_balanceOf[msg.sender] >= value) {

            _allowances[msg.sender][spender] = value;
            emit Approval(msg.sender, spender, value);
            return true;
        }

        return false;
    }
    
    function allowance(address owner, address spender) external view returns (uint) {
        if (_allowances[owner][spender] < _balanceOf[owner]) {
            return _allowances[owner][spender];
        }

        return _balanceOf[owner];

    }
   
}