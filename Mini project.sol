// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 

contract StudentSavingsWallet { // [cite: 18]
    address public owner;
        uint256 public minDeposit = 0.01 ether; // Bonus: Minimum deposit [cite: 33]

            // Struct to store transaction details 
                struct Transaction {
                        string txType;
                                uint256 amount;
                                        uint256 timestamp;
                                            }

                                                // Mapping to store user balances 
                                                    mapping(address => uint256) public balances;
                                                        
                                                            // Mapping to store transaction history for each user 
                                                                mapping(address => Transaction[]) public transactionHistory;

                                                                    // Events for transparency [cite: 33]
                                                                        event DepositMade(address indexed user, uint256 amount);
                                                                            event WithdrawalMade(address indexed user, uint256 amount);

                                                                                constructor() {
                                                                                        owner = msg.sender; // Bonus: Set admin role [cite: 34]
                                                                                            }

                                                                                                // Function to deposit ETH [cite: 19]
                                                                                                    function deposit() public payable {
                                                                                                            require(msg.value >= minDeposit, "Deposit amount is too low"); // [cite: 33]
                                                                                                                    
                                                                                                                            balances[msg.sender] += msg.value;
                                                                                                                                    
                                                                                                                                            // Record transaction history 
                                                                                                                                                    transactionHistory[msg.sender].push(Transaction({
                                                                                                                                                                txType: "Deposit",
                                                                                                                                                                            amount: msg.value,
                                                                                                                                                                                        timestamp: block.timestamp
                                                                                                                                                                                                }));

                                                                                                                                                                                                        emit DepositMade(msg.sender, msg.value); // [cite: 33]
                                                                                                                                                                                                            }

                                                                                                                                                                                                                // Function to withdraw ETH [cite: 19]
                                                                                                                                                                                                                    function withdraw(uint256 _amount) public {
                                                                                                                                                                                                                            require(balances[msg.sender] >= _amount, "Insufficient balance"); // [cite: 19]
                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                            balances[msg.sender] -= _amount;
                                                                                                                                                                                                                                                    payable(msg.sender).transfer(_amount);

                                                                                                                                                                                                                                                            // Record transaction history 
                                                                                                                                                                                                                                                                    transactionHistory[msg.sender].push(Transaction({
                                                                                                                                                                                                                                                                                txType: "Withdrawal",
                                                                                                                                                                                                                                                                                            amount: _amount,
                                                                                                                                                                                                                                                                                                        timestamp: block.timestamp
                                                                                                                                                                                                                                                                                                                }));

                                                                                                                                                                                                                                                                                                                        emit WithdrawalMade(msg.sender, _amount); // [cite: 33]
                                                                                                                                                                                                                                                                                                                            }

                                                                                                                                                                                                                                                                                                                                // View function to check balance [cite: 22]
                                                                                                                                                                                                                                                                                                                                    function getBalance() public view returns (uint256) {
                                                                                                                                                                                                                                                                                                                                            return balances[msg.sender];
                                                                                                                                                                                                                                                                                                                                                }

                                                                                                                                                                                                                                                                                                                                                    // View function to get full transaction history [cite: 22]
                                                                                                                                                                                                                                                                                                                                                        function getHistory() public view returns (Transaction[] memory) {
                                                                                                                                                                                                                                                                                                                                                                return transactionHistory[msg.sender];
                                                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                                                    }y