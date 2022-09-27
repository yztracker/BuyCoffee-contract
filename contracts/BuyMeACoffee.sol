// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

//contract address 0x9aa1A8796C692B4a65218127659597dEd5fc5d19
contract BuyMeACoffee {

    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message

    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo [] memos;

    //Address of contract deployer
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "eth is not enougth");

    //Add the memo to storage (memos array)
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));
    // Emit a log event when a new memo is created!
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
