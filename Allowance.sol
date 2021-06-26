// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Ownable.sol";
import "./SafeMath.sol";

contract Allowance is Ownable{
    
    using SafeMath for uint;
    event AllowanceChanged(address _who, address indexed _forWhom, uint _oldAmount, uint _newAmount);
    
    mapping(address => uint) public allowance;
    
    modifier ownerOrAllowed(uint _amount){
        require(msg.sender == owner() || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }
    
    function addAllowance(address _who, uint _amount) public onlyOwner{
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    function reduceAllowance(address _who, uint _amount) internal{
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
}