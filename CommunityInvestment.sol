pragma solidity >=0.7.0 <0.9.0;
import "./Ownable.sol";

contract CommunityInvestment is Ownable {
    mapping(address => uint256) balances;
    mapping(address => uint256) releaseDate;

    function deposit() public payable returns (bool) {
        require(msg.value > 1 ether, "Insufficient funds");
         if(balances[msg.sender] < 1)
        {
            releaseDate[msg.sender] += block.timestamp + 40 seconds;
        }
        balances[msg.sender] += msg.value;
        return true;
    }

    function getBalance() public view returns(uint256) {
        address contractAddress = (address(this));
        return contractAddress.balance;
    }

    function withdraw() public{
        require(block.timestamp > releaseDate[msg.sender], "Locked until release date");
        require(balances[msg.sender] > 0, "Insufficient funds");

        uint256 currentSenderAmount = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(currentSenderAmount);
    }

    function withdrawAll(address _recipient) public isOwner returns (bool) {
        uint256 myBalance = getBalance();
        payable(_recipient).transfer(myBalance);
        return true;
    }
}