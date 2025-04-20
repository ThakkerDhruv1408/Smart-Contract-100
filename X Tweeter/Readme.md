# X2 Smart Contract

A decentralized Twitter-like social media platform built on Ethereum blockchain using Solidity.

## Overview

X2 is a smart contract that allows users to create, like, and unlike tweets in a decentralized manner. The contract ensures data integrity and user interactions are maintained on the blockchain, providing transparency and censorship resistance.

## Features

- **Create Tweets**: Users can post tweets with a configurable character limit
- **Like/Unlike Tweets**: Users can like and unlike tweets with proper validation
- **User Tracking**: The system tracks who has liked each tweet
- **Tweet Management**: View individual tweets or all tweets from a specific user
- **Owner Controls**: Contract owner can adjust the maximum tweet length

## Smart Contract Details

### Tweet Structure

Each tweet contains:
- `id`: Unique identifier for the tweet
- `author`: Ethereum address of the tweet creator
- `content`: The message content
- `timestamp`: When the tweet was created
- `likes`: Number of likes received

### Core Functions

#### Tweet Management

- `createTweet(string memory _tweet)`: Post a new tweet
- `getTweet(address _owner, uint _i)`: Get a specific tweet from a user
- `getAllTweet(address _owner)`: Get all tweets from a user

#### Like System

- `likeTweet(address author, uint256 _id)`: Like a tweet
  - Validates that the user hasn't already liked the tweet
- `unlikeTweet(address author, uint256 _id)`: Unlike a tweet
  - Validates that the user has previously liked the tweet
- `hasLikedTweet(address author, uint256 _id, address liker)`: Check if a user has liked a specific tweet

#### Admin Functions

- `changeMaxTweetLength(uint16 _newLength)`: Allows the contract owner to change the maximum tweet length

## Like System Constraints

The contract implements the following constraints for the like system:
- A user can only like a tweet once
- Only a user who has liked a tweet can unlike it
- Users can like and unlike as many times as they want (toggle between states)
- The like count accurately reflects the number of unique users who have liked the tweet

## Usage Examples

### Creating a Tweet

```solidity
// Deploy the contract
X2 x2Contract = new X2();

// Create a tweet
x2Contract.createTweet("Hello, Web3 world!");
```

### Liking a Tweet

```solidity
// Like a tweet (parameters: author's address, tweet ID)
x2Contract.likeTweet(0x123...abc, 0);
```

### Checking if a User Has Liked a Tweet

```solidity
// Check if a specific user has liked a tweet
bool hasLiked = x2Contract.hasLikedTweet(0x123...abc, 0, 0x456...def);
```

## Development

### Prerequisites

- Solidity 0.8.17 or higher
- Ethereum development environment (Hardhat, Truffle, or Remix)
- Ethereum wallet (MetaMask) for testing

### Deployment

1. Compile the smart contract
2. Deploy to your preferred Ethereum network (testnet or mainnet)
3. Interact with the contract through a dApp frontend or directly via contract calls

## Security Considerations

- The contract uses proper validation to ensure users can only interact with existing tweets
- Like counts are protected from manipulation
- The contract tracks who has liked each tweet to prevent multiple likes from a single user

## License

[MIT License](LICENSE)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.