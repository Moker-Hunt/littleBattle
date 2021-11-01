pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "playObject.sol";
import "forAction.sol";
import "forAction.sol";

contract MilitaryUnit is playObject {

    address public townHallAddress;

    constructor(address _addr, uint _hp) public {
        require(tvm.pubkey() != 0, 101);
        tvm.accept();
        townHallAddress = _addr;
        forAction(townHallAddress).actionWithUnit(_hp, true);
        
        //add unit to townHall
    }

    uint public dmg;

    function death(address _addr) virtual public override checkOwnerAndAccept {
        //delete unit from townHall
        forAction(townHallAddress).actionWithUnit(hp, false);
        _addr.transfer(0, true, 128 + 32);
    }

    function dealDmg(playingObject _addr) checkOwnerAndAccept public {
        _addr.getDmg(dmg);
    }
}
