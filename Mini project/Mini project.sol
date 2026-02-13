// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Requirement: Solidity version ^0.8.x

contract StudentSavingsWallet { // Requirement: Name the contract
    address public owner; // Bonus: Implement owner role
    uint256 public minDeposit = 0.01 ether; // Bonus: Minimum deposit

    // Requirement: Store transaction history using a struct
    struct Transaction {
        string txType;
        uint256 amount;
        uint256 timestamp;
    }

    // Requirement: Store user balances using a mapping
    mapping(address => uint256) public balances;
    
    // Requirement: Store transaction history using an array
    mapping(address => Transaction[]) public transactionHistory;

    // Bonus: Emit events for deposits and withdrawals
    event DepositMade(address indexed user, uint256 amount);
    event WithdrawalMade(address indexed user, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // Requirement: Allow users to deposit ETH using a payable function
    function deposit() public payable {
        require(msg.value >= minDeposit, "Deposit amount is too low"); 
        
        balances[msg.sender] += msg.value;
        
        transactionHistory[msg.sender].push(Transaction({
            txType: "Deposit",
            amount: msg.value,
            timestamp: block.timestamp
        }));

        emit DepositMade(msg.sender, msg.value);
    }

    // Requirement: Allow users to withdraw ETH only if sufficient balance exists
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        transactionHistory[msg.sender].push(Transaction({
            txType: "Withdrawal",
            amount: _amount,
            timestamp: block.timestamp
        }));

        emit WithdrawalMade(msg.sender, _amount);
    }

    // Requirement: Provide view function to check balance
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Requirement: Provide view function to check transaction history
    function getHistory() public view returns (Transaction[] memory) {
        return transactionHistory[msg.sender];
    }
}                                                                                                                                                                                                                                                                                                                                                return transactionHistory[msg.sender];
                                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                                    }
