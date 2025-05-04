//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract HelloBlockchainWorld{
    string private Greetings;
    uint8 private constant MAX_GREETING_LENGTH = 100;
    address private owner;

    event Update (string updateGreeting, address changedBy);

    constructor(string memory _initialGreeting){
        require(bytes(_initialGreeting).length <= MAX_GREETING_LENGTH, "Too long sir, Think a little less!)");
        Greetings = _initialGreeting;
        owner = msg.sender;
        emit Update(_initialGreeting, msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the boss of this contract!");
        _;
    }

    function updateGreetings(string memory _newGreetings) external onlyOwner{
        Greetings = _newGreetings;
        emit Update(_newGreetings, msg.sender);
    }

    function getMessage() external view returns (string memory){
        return Greetings;
    }

}