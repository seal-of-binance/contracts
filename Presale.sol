pragma solidity 0.6.12;

contract Presale {
    address payable owner;
    
    struct participation {
        address participant;
        uint amount;
        bool exist;
    }
    
    event newParticipant(address val);
    address[] public list;
    mapping(address => participation) public participations;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function listCount() public view returns (uint256) {
        return list.length;
    }
    
    function amountLocked() public view returns (uint) {
        return participations[msg.sender].amount;
    }
    
    function deposit() payable public {
        // 100000000 = 0.1 ether
        require(participations[msg.sender].exist == false, "already exist");
        require(msg.value >= 0.05 ether, "amount too low");
        require(msg.value <= 10 ether, "amount too high");
        list.push(msg.sender);
        participations[msg.sender].participant = msg.sender;
        participations[msg.sender].amount = participations[msg.sender].amount+msg.value;
        participations[msg.sender].exist = true;
        emit newParticipant(msg.sender);
    }
    
    function destruct() payable public {
        require(msg.sender == owner, "Error, you're not the owner");
        selfdestruct(owner);
    }
}