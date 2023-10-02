// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract toVote {
    address private owner;//Address of the contract owner
    mapping(address => bool) private okvoters;//Mapping to tract the registered voters
    mapping(address => bool) private aVoted; //Mapping to tract voters who have already voted
    uint256 private nbrVote; //Total vote count

    constructor() {
        owner = msg.sender; //Initialize the owner as the deployer of the contract
        nbrVote = 0; // Initialize the vote count
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can do this");
        _; 
    }

    modifier OnlyokVoters() {
        require(okvoters[msg.sender], "Only recognized voters can perform this action");
        _;
    }

    function addvoters(address _voteradd) public onlyOwner {
        require(!okvoters[_voteradd], "Voter is already registered");
        okvoters[_voteradd] = true; //Register a new voter
    }

    function Vote() public OnlyokVoters {
        require(!aVoted[msg.sender], "You have already voted, sorry");
        aVoted[msg.sender] = true;//Mark the voter as having voted
        nbrVote++;  //Increment the total vote count 
    }

    function getnbrVote() public view returns (uint256) {
        return nbrVote;  //Retrieve the total vote count 
    }
}
