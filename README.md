# MyCustom ERC20 Token Implementation

## Overview
This project is a custom implementation of the ERC20 token standard in Solidity. It provides a fully functional ERC20 token with standard features like transfer, approval, and allowance mechanisms.

## Features
- **Minting : Allows the contract owner to mint new tokens.
- **Transfers**: Supports transferring tokens between accounts.
- **Approvals & Allowance**: Implements `approve`, `transferFrom`, and `allowance` functions to enable third-party transfers.
- **Events**: Emits standard ERC20 events for transparency.

## Smart Contract Functions

### **State Variables**
- `name`: The name of the token.
- `symbol`: The ticker symbol of the token.
- `decimals`: The number of decimal places.
- `totalSupply`: The total number of tokens in existence.
- `balances`: Mapping of addresses to their respective token balances.
- `allowances`: Mapping of allowances granted by owners to spenders.

### **Functions**
#### 🔹 `constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply)`
Initializes the token with its name, symbol, decimals, and an initial supply.

#### 🔹 `balanceOf(address account) public view returns (uint256)`
Returns the token balance of the specified address.

#### 🔹 `transfer(address recipient, uint256 amount) public returns (bool)`
Transfers tokens from the sender to the recipient.

#### 🔹 `approve(address spender, uint256 amount) public returns (bool)`
Approves a third party (`spender`) to spend `amount` of tokens on behalf of the sender.

#### 🔹 `allowance(address owner, address spender) public view returns (uint256)`
Returns the remaining amount that `spender` is allowed to spend on behalf of `owner`.

#### 🔹 `transferFrom(address sender, address recipient, uint256 amount) public returns (bool)`
Transfers tokens from `sender` to `recipient`, using an approved allowance.

#### 🔹 `mint(address account, uint256 amount) public` 
Allows the owner to create new tokens and assign them to an account.


## Events
- `Transfer(address indexed from, address indexed to, uint256 value)` - Emitted when tokens are transferred.
- `Approval(address indexed owner, address indexed spender, uint256 value)` - Emitted when a new allowance is set.



## License
This project is UNLICENSED

