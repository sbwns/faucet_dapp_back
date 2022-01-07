//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Faucet {

    //mapping of addresses and a timestamp
    mapping(address => uint256) public lastUse;

    constructor() payable {
        console.log("Deploying faucet contract");
    }

    receive() external payable {}

    function useFaucet() public {
        // set faucet drip amount
        uint256 droplet = 0.1 ether;
        require(
            droplet <= address(this).balance, "Faucet is currently dry, sorry!"
        );

        // only let people out of cooldown claim
        require(
            lastUse[msg.sender] + 24 hours < block.timestamp, "Cooldown time of 24 hours"
        );
        
        lastUse[msg.sender] = block.timestamp;

        // this line is the magic where money is sent from contract to user
        (bool success, ) = (msg.sender).call{value: droplet}("");
        require(success, "Failed to withdraw money from contract.");
    }
}
