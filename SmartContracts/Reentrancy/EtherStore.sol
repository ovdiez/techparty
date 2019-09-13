pragma solidity 0.4.26;

/**
 * @dev Acts as an Ethereum vault that allows depositors to withdraw only 1 ether per week.
 */
contract EtherStore {

    //set the withdrawal limit to 1 ether
    uint256 public withdrawalLimit = 1 ether;

    //set a mapping with the address and their last withdrawal time
    mapping(address => uint256) public lastWithdrawTime;

    //set a mapping with the addresses and their balances
    mapping(address => uint256) public balances;

    /**
     * @dev Deposit ETH from the sender addresses to the contract
     * Increments the sender’s balance
     */
    function depositFunds() public payable {
        balances[msg.sender] += msg.value;
    }

    /**
     * @dev withdraw ETH from the contract to the sender address
     *
     * Requirements:
     * - `sender` must have a balance of at least `_weiToWithdraw`.
     * - `_weiToWithdraw` must be <= 1 Ether.
     * - Actual Date must be >= Last Date Withdraw + 1 weeks
     */
    function withdrawFunds (uint256 _weiToWithdraw) public {
        //Limit the withdrawal
        require(balances[msg.sender] >= _weiToWithdraw);
        require(_weiToWithdraw <= withdrawalLimit);

        //Limit the time allowed to withdraw
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);

        //Send ether to the msg.sender
        require(msg.sender.call.value(_weiToWithdraw)());

        //Update the sender balance
        balances[msg.sender] -= _weiToWithdraw;

        //Update the last withdraw time
        lastWithdrawTime[msg.sender] = now;
    }

    /**
     * @dev return the smart contract balance
     */
    function getBalance () public view returns (uint256) {
        return address(this).balance;
    }
 }
