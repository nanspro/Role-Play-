contract Gold {

    string public name = "Gold";
    string public symbol = "GOLD";
    uint8 public decimals = 4;
    uint public totalSupply;
    mapping(address => uint) balances;
    
    function Gold() public {
        totalSupply = 1000;
        balances[msg.sender] = 100;
    }


    function totalSupply() public constant returns (uint){
        return totalSupply;
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance){
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success){

    }

}