// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract YourToken {
    string public name = "Your Token"; // Token name
    string public symbol = "YOUR"; // Token short name
    uint256 public totalSupply = 1000000000 * 10 ** 18; // Total supply: 1,000,000,000 with 18 decimals
    uint8 public decimals = 18;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Constructor function to initialize the total supply of ChatGPT Coin.
     */
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    /**
     * @dev Transfer tokens from sender's account to another account.
     * @param _to The address to transfer tokens to.
     * @param _value The amount of tokens to transfer.
     * @return success Returns true if the transfer is successful, otherwise returns false.
     */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * @dev Approve another address to spend tokens on behalf of the sender.
     * @param _spender The address to approve spending.
     * @param _value The amount of tokens to approve for spending.
     * @return success Returns true if the approval is successful, otherwise returns false.
     */
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * @dev Transfer tokens from one address to another address on behalf of a token holder.
     * @param _from The address to transfer tokens from.
     * @param _to The address to transfer tokens to.
     * @param _value The amount of tokens to transfer.
     * @return success Returns true if the transfer is successful, otherwise returns false.
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_from != address(0), "Invalid sender address");
        require(_to != address(0), "Invalid recipient address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
