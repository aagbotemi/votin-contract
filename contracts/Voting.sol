// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Voting {
    address owner;
    address[] registeredVoter;
    Contestant[] registeredContestant;
    mapping(address => uint256) voteCounter;
    mapping(address => bool) alreadyVoted;
    struct Contestant {
        address contestant;
        string name;
    }


    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not eligible to perform this!");
        _;
    }

    /// @notice voters can register, so that contract can have their info in the database
    function RegisterVoter() external {
        address _voter = msg.sender;
        require(_voter != address(0), "Cannot add address zero!");

        bool status = validRegisteredVoter(_voter);

        if (!status) {
            registeredVoter.push(_voter);
        } else {
            revert("Already registered!");
        }
    }

    function validRegisteredVoter(address _address)
        private
        view
        returns (bool status)
    {
        for (uint256 i = 0; i < registeredVoter.length; i++) {
            if (_address == registeredVoter[i]) {
                status = true;
            } else {
                status = false;
            }
        }
    }

    function RegisterContestant(address _contestant, string memory _name) external onlyOwner {
        // Contestant storage contestant =
        bool status = validRegisteredContestant(_contestant);
        if (!status) {
            registeredContestant.push(Contestant(_contestant, _name));
        } else {
            revert("Already registered!");
        }
    }

    function validRegisteredContestant(address _address)
        private
        view
        returns (bool status)
    {
        for (uint256 i = 0; i < registeredContestant.length; i++) {
            if (_address == registeredContestant[i].contestant) {
                status = true;
            } else {
                status = false;
            }
        }
    }


    function vote(address _contestant) external {
        address _voter = msg.sender;
        bool contestantStatus = validRegisteredContestant(_contestant);
        require(contestantStatus, "This address is not a contestant");
        bool status = validRegisteredVoter(_voter);

        if(alreadyVoted[_voter] == true) {
            revert("You've already casted your vote!");
        }

        if (status) {
            alreadyVoted[_voter] = true;
            voteCounter[_contestant] += 1;
        }
    }
}
