pragma solidity 0.4.16;

/**
 * @dev A Smart Contract game in wich if a user has a address such as
 * uint8(msg.sender)>uint8(address(this)) wins the Smart Contract balance.
 */
contract AddressGame {

    /**
    * @dev Play the game
    */
    function playGame() {
        require(uint8(msg.sender) > uint8(address(this)));
        sendWinnings();
     }

    /**
    * @dev Transfer to the user the Smart Contract balance
    */
     function sendWinnings() {
         msg.sender.transfer(address(this).balance);
     }

    /**
    * @dev Show uint256(address)
    */
     function showUint8Address(address _address) public view returns (uint8) {
         return uint8(_address);
     }

    /**
     * @dev Return the smart contract balance
     */
    function getBalance () public view returns (uint256) {
        return address(this).balance;
    }

    /**
    * @dev FallBack Function
    */
    function () external payable {
    }
}
