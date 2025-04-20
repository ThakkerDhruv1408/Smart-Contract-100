//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract X2 {
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;
    // Track which users have liked each tweet: author => tweetId => liker => hasLiked
    mapping(address => mapping(uint256 => mapping(address => bool))) public tweetLikes;
    
    uint16 public Tweet_Length = 280;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action;");
        _;
    }

    function changeMaxTweetLength(uint16 _newLength) public onlyOwner {
        Tweet_Length = _newLength;
    }

    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= Tweet_Length, "Tweet length exceed the limit!");
        
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }

    function likeTweet(address author, uint256 _id) external {
        require(tweets[author][_id].id == _id, "Tweet does not exist!");
        require(!tweetLikes[author][_id][msg.sender], "You have already liked this tweet!");
        
        tweets[author][_id].likes++;
        tweetLikes[author][_id][msg.sender] = true;
    }

    function unlikeTweet(address author, uint256 _id) external {
        require(tweets[author][_id].id == _id, "Tweet does not exist!");
        require(tweets[author][_id].likes > 0, "Tweet has No likes");
        require(tweetLikes[author][_id][msg.sender], "You haven't liked this tweet yet!");

        tweets[author][_id].likes--;
        tweetLikes[author][_id][msg.sender] = false;
    }

    function getTweet(address _owner, uint _i) public view returns (Tweet memory) {
        return tweets[_owner][_i];
    }

    function getAllTweet(address _owner) public view returns(Tweet[] memory) {
        return tweets[_owner];
    }
    
    function hasLikedTweet(address author, uint256 _id, address liker) public view returns (bool) {
        return tweetLikes[author][_id][liker];
    }
}