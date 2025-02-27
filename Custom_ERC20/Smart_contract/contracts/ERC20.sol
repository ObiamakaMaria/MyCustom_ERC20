// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

contract ERC20 {

    string  tokenName;
    string  tokenSymbol;
    uint8   tokenDecimals;
    address immutable owner;
    uint256 private totalsupply;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;

    error addressZero();
    error InsufficientBalance();
    error ownerOnly();
    error InvalidAmount();


    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    modifier OnlyOwner() {
        if(msg.sender!= owner ) {
            revert ownerOnly();
        }
        _;
    }


    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply)  {
        tokenName = _name;
        tokenSymbol = _symbol;
        tokenDecimals = _decimals;
        totalsupply = _totalSupply;
        owner = msg.sender;

        
    }

    function name() public view returns (string memory) {
        return tokenName;
    }

    function symbol() public view returns (string memory) {
        return tokenSymbol;
    }

    function decimals() public view returns (uint8) {
        return tokenDecimals;
    }

    function totalSupply() public view returns (uint256) {
        return totalsupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        if (_owner == address(0)) revert addressZero();
        
        balance = balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        if (_to == address(0)) revert addressZero();
        

        if (balances[msg.sender] < _value ) revert InsufficientBalance();
        

        balances[msg.sender] -= _value;
        balances[_to] += _value;
        
        emit Transfer(msg.sender, _to, _value);
        success = true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        if (msg.sender == address(0)) revert addressZero();
        
        if (_from == address(0)) revert addressZero();
    

        if (_to == address(0)) revert addressZero();

        if (balances[_from] < _value) revert InsufficientBalance();
        
        if (allowances[_from][msg.sender] < _value) revert InsufficientBalance();
        
        balances[_from] -= _value;
        allowances[_from][msg.sender] += _value;
        balances[_to] +=_value;

        emit Transfer(_from, _to, _value);
        success = true;
        
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {

        if (msg.sender == address(0)) revert addressZero();
        

        if (_spender == address(0)) revert addressZero();
        

        if (balances[msg.sender] < _value) revert InsufficientBalance();
        

        allowances[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        success = true;

    }

    function allowance(address _owner, address _spender) public view OnlyOwner returns (uint256 remaining) {
        if (_owner == address(0)) revert addressZero();
        

        if (_spender == address(0)) revert addressZero();
        
        remaining = allowances[_owner][_spender];      
    }

    function mint(address _to, uint256 _value) public OnlyOwner  returns (bool success) {
         if (_to == address(0)) revert addressZero();
        if (_value <= 0) revert InvalidAmount();
        

        totalsupply += _value;
        balances[_to] += _value; 
        success = true;

    }
    
}