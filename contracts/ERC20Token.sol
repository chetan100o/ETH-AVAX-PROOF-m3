// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    address owner;
    uint public _totalSupply;
    address private _owner;
    mapping(address => uint256) private _balances;

    event Burn(address from, uint256 value);
    event Mint(address to, uint256 value);

    
    constructor() ERC20("darkvoid", "DV") {
        owner= msg.sender;

    }

    /**
     * Modifier to restrict function execution to the contract owner only
     */
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can execute this function");
        _;
    }

    function mint(address to, uint256 value) public onlyOwner returns (bool) {
        _balances[to] += value;
        _totalSupply += value;
        emit Mint(to, value);
        return true;
    }
    
    function burn(uint256 value) public {
        address sender = msg.sender;
        _balances[sender] -= value;
        _totalSupply -= value;
        emit Burn(sender, value);
    }

    function getOwner() external view returns (address) {
        return _owner;
    }
}
