pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "playingObject.sol";

contract playObject is playingObject{

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    uint static private num;
    address static private addres;

    uint public hp;
    mapping (uint => uint) public set;
   

    modifier checkOwnerAndAccept() {
        require(tvm.pubkey() == msg.pubkey(), 101);
        tvm.accept();
        _;
    }

    function checkAlive(uint dmg) private returns(bool) {
        if(hp <= dmg) {
            return false;
        } else {
            return true;
        }
    }

    function death(address _addr) virtual public checkOwnerAndAccept {
        _addr.transfer(0, true, 128 + 32);
    }

    function getDmg(uint dmg) virtual public override {
        if(checkAlive(dmg)){
            hp -= dmg;
        }else{
            death(msg.sender);    
        }
    }
}
