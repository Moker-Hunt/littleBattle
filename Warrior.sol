pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilitaryUnit.sol";

contract Warrior is MilitaryUnit {
    
    constructor(address _addr) MilitaryUnit(_addr, 20) public {
        hp = 20;
        dmg = 10;
    }
    
}