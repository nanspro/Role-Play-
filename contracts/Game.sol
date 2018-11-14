pragma solidity ^0.4.18;

import "./Gold.sol";

contract Game{

    struct Player{
        uint[] attacks;
        //uint[] defenses;
        uint[4] moves;
        uint exp;
        uint health;
        uint gold;
        string handle;        
        address[] challenges_inbox;
        address[] challenges_sent;
        address id;
    }
    address[] request_list;
    address public moderator;
    Player[] public players;
    constructor() public {
        moderator = msg.sender;
    }

    function register_player({ uint[] attacks, uint[] defenses, uint exp, uint health, uint gold, uint handle }) public {
        require(moderator != msg.sender);
        players.push(Player({
            attacks: attacks,
            defenses: defenses,
            exp: exp,
            health: health,
            gold: gold,
            handle: handle,
        }));
    }

    function challenge_player(address to, uint[] move){
        address player = msg.sender;
        uint from = index_player(msg.sender);
        uint _to = index_player(to);
        players[_to].challenges_inbox.push(players[from].id);
        players[from].challenges_sent.push(to);
        players[from].moves = move;

    }

    function index_player(address player){
        for (uint i = 0; i < players.length; i++){
            if (players[i].id == player){
                uint from = i;
            }
        }
        returns from;
    }

    function accept_challenge(uint idx, uint[] moves){
        uint from = index_player(msg.sender);
        players[from].moves = moves;
        request_list.push(players[from].id);
        request_list.push(players[from].challenges_inbox[idx]);
    }

    function see_requests(){
        require(msg.sender != moderator);
        for (uint i = 0; i < request_list.length; i+=2){
            play(request_list[i], request_list[i + 1]);
        }
        request_list = [];
    }

    function play(address p1, address p2){
        require(msg.sender != moderator);
        address winner = get_winner(p1, p2);
        if(p1 == winner){
            address loser = p2;
        }
        else{
            address loser = p1;
        }
        uint idx_winner = index_player(winner);
        uint idx_loser = index_player(loser);
        uint c = players[idx_winner].exp - players[idx_loser].exp; 
        players[idx_winner].gold += c;
        players[idx_loser].gold -= c;
        players[idx_winner].exp += 5*c;
        players[idx_loser].exp -= 3*c;
       // players[idx_winner].gold += players[idx_loser].gold 
    }

    function buy_gold() private payable{
        uint no_gold = convert(msg.value);
        uint idx = index_term(msg.sender);
        players[idx].gold += no_gold;       
    }

    function get_winner(address p1, address p2){
        require((msg.sender != moderator));
        idx1 = index_term(p1);
        idx2 = index_term(p2);
        // TODO implement a turn based smart contract so that winner will be calculated by each attack and defense pattern
        P1 = players[idx1];
        P2 = players[idx2];
        uint difference = 0;
        for (uint i = 0; i < P1.moves.length; i++){
            difference += P1.attacks[moves[i]] - P2.attacks[moves[i]];
        }   
        if (difference > 0){
            returns p1;
        }
        else{
            returns p2;
        }
    }