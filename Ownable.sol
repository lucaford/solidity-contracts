pragma solidity >=0.7.0 <0.9.0;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner, "You're not the owner");
        _;
    }

    function setOwner(address _newOwner) public isOwner returns (bool) {
        owner = _newOwner;
        return true;
    }
}