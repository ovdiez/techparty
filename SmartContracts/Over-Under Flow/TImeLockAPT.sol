pragma solidity 0.5.0;

import "./SafeMath.sol";

/**
 * @dev Act like a time vault
 * Users can deposit ETH and it will be locked for at least a week.
 * Users may extend the wait time to longer than 1 week
 */
contract TimeLockAPT {
    //Use SafeMath Libray
    using SafeMath for uint;

    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    /**
    * @dev Deposit ETH to the smart contract
    */
    function deposit() public payable {
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        lockTime[msg.sender] = now.add(1 weeks);
    }

    /**
    * @dev Increase the time to lock the deposits (in seconds)
    */
    function increaseLockTime(uint _secondsToIncrease) public {
        lockTime[msg.sender] = lockTime[msg.sender].add(_secondsToIncrease);
    }

    /**
    * @dev withdraw the deposit after at least a week
    */
    function withdraw() public {
        require(balances[msg.sender] > 0);
        require(now > lockTime[msg.sender]);
        balances[msg.sender] = 0;
        msg.sender.transfer(balances[msg.sender]);
    }

    /**
     * @dev return the smart contract balance
     */
    function getBalance () public view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev return now
     */
    function getNow () public view returns (uint256) {
        return now;
    }
}
