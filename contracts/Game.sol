pragma solidity ^0.4.18;

import "./Gold.sol";

contract Game{

    struct Player{
        uint16[] attacks;
        uint16[] moves;
        uint16 exp;
        uint16 health;
        uint16 gold;
        string handle;        
        address[] challenges_inbox;
        address[] challenges_sent;
        address id;
    }
    // uint16 public num_players = 1; 
    // address[] request_list;
    // address public moderator;
    // Player[] public players;
    mapping (uint16 => Player) public players;
    uint16 playerCount = 0;
    // constructor() public {
    //     moderator = msg.sender;
    // }

    function register_player(uint16[] memory _attacks, uint16 exp, uint16 health, uint16 gold, string handle) public {
        // require(moderator != msg.sender);
        address[] memory challenges_inbox_ = new address[](3);
        // challenges_inbox_[0]=1;
        // challenges_inbox_[1]=2;
        // challenges_inbox_[2]=3;
        address[] memory challenges_sent_ =  new address[](0);
        uint16[] memory moves_ =  new uint16[](0);
        Player memory playerInstance;// = Player(_attacks,moves_,exp,health,gold,handle,challenges_inbox_,challenges_sent_,msg.sender);
        playerInstance.attacks=_attacks;
        playerInstance.moves=moves_;
        playerInstance.exp=exp;
        playerInstance.health=health;
        playerInstance.gold=gold;
        playerInstance.handle=handle;
        playerInstance.challenges_inbox=challenges_inbox_;
        playerInstance.challenges_sent=challenges_sent_;
        playerInstance.id=msg.sender;
        players[playerCount++] = playerInstance;
    }

    // function challenge_player(address to, uint16[4] move) public {
    //     address player = msg.sender;
    //     uint16 from = index_player(msg.sender);
    //     uint16 _to = index_player(to);
    //     players[_to].challenges_inbox.push(players[from].id);
    //     players[from].challenges_sent.push(to);
    //     players[from].moves = move;
    // }

    // function index_player(address player)
    // private
    // returns(uint16)
    // {   
    //     uint16 from;
    //     for (uint16 i = 0; i < playerCount; i++){
    //         if (players[i].id == player){
    //             from = i;
    //         }
    //     }
    //     return from;
    // }

    // function accept_challenge(uint16 idx, uint16[4] moves) public{
    //     uint16 from = index_player(msg.sender);
    //     players[from].moves = moves;
    //     request_list.push(players[from].id);
    //     request_list.push(players[from].challenges_inbox[idx]);
    // }

    // function see_requests() public { //rename to start games
    //     require(msg.sender != moderator);
    //     for (uint16 i = 0; i < request_list.length; i+=2){
    //         play(request_list[i], request_list[i + 1]);
    //     }
    //     request_list.length=0;
    // }

    // function play(address p1, address p2) public {
    //     require(msg.sender != moderator);
    //     address winner = get_winner(p1, p2);
    //     address loser;
    //     if(p1 == winner){
    //         loser = p2;
    //     }
    //     else{
    //         loser = p1;
    //     }
    //     uint16 idx_winner = index_player(winner);
    //     uint16 idx_loser = index_player(loser);
    //     uint16 c = players[idx_winner].exp - players[idx_loser].exp; 
    //     players[idx_winner].gold += c;
    //     players[idx_loser].gold -= c;
    //     players[idx_winner].exp += 5*c;
    //     players[idx_loser].exp -= 3*c;
    //    // players[idx_winner].gold += players[idx_loser].gold 
    // }

    // function buy_gold() public payable{
    //     // uint16 no_gold = convert(msg.value);
    //     uint16 no_gold = msg.value;
    //     uint16 idx = index_player(msg.sender);
    //     players[idx].gold += no_gold;       
    // }

    // function get_winner(address p1, address p2) public returns(address){
    //     require((msg.sender != moderator));
    //     uint16 idx1 = index_player(p1);
    //     uint16 idx2 = index_player(p2);
    //     // TODO implement a turn based smart contract so that winner will be calculated by each attack and defense pattern
    //     Player P1 = players[idx1];
    //     Player P2 = players[idx2];
    //     uint16 difference = 0;
    //     for (uint16 i = 0; i < P1.moves.length; i++){
    //         difference += P1.attacks[P1.moves[i]] - P2.attacks[P1.moves[i]];
    //     }   
    //     if (difference > 0){
    //         return p1;
    //     }
    //     else{
    //         return p2;
    //     }
    // }
}