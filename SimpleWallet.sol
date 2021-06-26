// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Allowance.sol";

contract SimpleWallet is Allowance{
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function withdrawMoney(address payable _to, uint _amount)public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contract.");
        if(msg.sender != owner()){
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }
    
    function renounceOwnership() public pure override(Ownable) {
        revert("Cannot renounce ownership here");
    }
    
    receive() external payable{
        emit MoneyReceived(msg.sender, msg.value);
    }
    
    fallback() external payable{
        emit MoneyReceived(msg.sender, msg.value);
    }
    
    function receiveMoney() external payable{
        emit MoneyReceived(msg.sender, msg.value);
    }
}
