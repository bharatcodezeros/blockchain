// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract KTP is ERC20 {
    uint public percent;
    address private admin;
    using SafeMath for uint;

    constructor() ERC20("KTP","K"){
        _mint(msg.sender,5000 * 10 **9);
        admin = msg.sender;
    }
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    function transfer(address to, uint amount) public  override returns(bool){
        // percent = (amount / 100) * percent;
        percent = (amount.div(100)).mul(percent);
        amount = amount.sub(percent);
        _transfer(msg.sender,to,amount);
    }

    function setPercent(uint _percent)public onlyAdmin{
        percent = _percent;
    }

}
