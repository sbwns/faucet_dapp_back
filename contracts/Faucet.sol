//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Faucet {
    // seed
    uint256 private seed;
    //mapping of addresses and a timestamp
    mapping(address => uint256) public lastUse;

    constructor() payable {
        console.log("Deploying faucet contract");

    }

    function useFaucet() public {
        // set faucet drip amount
        uint256 droplet = 0.1 ether;
        require(
            droplet <= address(this).balance, "Faucet is currently dry, sorry!"
        );
        // this line is the magic where money is sent from contract to user
        (bool success, ) = (msg.sender).call{value: droplet}("");
        require(success, "Failed to withdraw money from contract.");
    }
}
