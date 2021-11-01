pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "playObject.sol";
import "forAction.sol";

contract TownHall is playObject, forAction{

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

        hp = 30;
    }

    mapping (address => uint) townHallUnits;

    function actionWithUnit(uint _hp, bool f) virtual public override {
        if(f) {
            townHallUnits[msg.sender] = _hp;
        }else{
            delete townHallUnits[msg.sender];
        }
    }

    function death(address _addr) virtual public override checkOwnerAndAccept {
        //delete unit from townHall
        for((address _adr, uint _dmg):townHallUnits) {
            playObject(_addr).getDmg(_dmg);
        }
        _addr.transfer(0, true, 128 + 32);
    }

    function viewAllUnits() public returns(mapping (address => uint)) {
        return townHallUnits;
    }
}
