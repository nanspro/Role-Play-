var web3Provider = null;
var gameContract;
var user_address;
var gameInstance;
const nullAddress = "0x0000000000000000000000000000000000000000";


var fightScreen = $("#fight")
var eventScreen = $("#eventsList")
var characterChoice = $("#characterChoice");
characterChoice.show();
fightScreen.hide()
eventScreen.hide()


function init() {
  // We init web3 so we have access to the blockchain
  initWeb3();
}

function initWeb3() {
  if (typeof web3 !== 'undefined' && typeof web3.currentProvider !== 'undefined') {
    web3Provider = web3.currentProvider;
    web3 = new Web3(web3Provider);
  } else {    
    console.error('No web3 provider found. Please install Metamask on your browser.');
    alert('No web3 provider found. Please install Metamask on your browser.');
  }
  
  // we init The Wrestling contract infos so we can interact with it
  initGameContract();
}


function initGameContract () {
  $.getJSON('Game.json', function(data) {
    // Get the necessary contract artifact file and instantiate it with truffle-contract
    gameContract = TruffleContract(data);
    
    // Set the provider for our contract
    gameContract.setProvider(web3Provider);

    // listen to the events emitted by our smart contract
    getEvents ();

    // We'll retrieve the Wrestlers addresses set in our contract using Web3.js
    render();
  });
}

function render(){
  web3.eth.getCoinbase(function(err, account) {
    if (err === null) {
      user_address = account;
      $("#accountAddress").html("Your Account: " + account);
    }
  });
  gameContract.deployed().then(function(instance){
    gameInstance = instance;
    
    return instance;
  }).then(function(gameInstance){
    gameInstance.characterCount().then(function(characterCount){
      console.log(characterCount);
      for (let index = 0; index < characterCount; index++) {
        console.log(characterCount);
        gameInstance.characters(index).then(function(character){
          var characterName = character[0];
          var attack1 = character[1];
          var attack2 = character[2];
          var attack3 = character[3];
          console.log(characterName,attack1,attack2,attack3);
          characterTemplate = "<div class=\"col-sm-4\"><h4>"+characterName+"</h4><p>Attack1: "+attack1+"</p><p>Attack2: "+attack2+"</p><p>Attack3: "+attack3+"</p><button type=\"button\"  onclick=\"chooseCharacter("+index+")\" class=\"btn btn-primary\">Choose</button></div>"
          characterChoice.append(characterTemplate);
        })
      }
    })
  })
}

function chooseCharacter(number){
  characterChoice.hide();
  gameInstance.register_player(number).then(function(){
    console.log(user_address)
    gameInstance.players_map(user_address).then(function(index){
      console.log(index);
      gameInstance.players(index).then(function(player){
        console.log(player[6])
      })
    })
  })
}





function getEvents () {
  gameContract.deployed().then(function(instance) {
  var events = instance.allEvents(function(error, log){
    if (!error)
      $("#eventsList").prepend('<li>' + log.event + '</li>'); // Using JQuery, we will add new events to a list in our index.html
  });
  }).catch(function(err) {
    console.log(err.message);
  });
}



// function registerAsSecondWrestler () {
//   web3.eth.getAccounts(function(error, accounts) {
//   if (error) {
//     console.log(error);
//   } else {
//     if(accounts.length <= 0) {
//       alert("No account is unlocked, please authorize an account on Metamask.")
//     } else {
//       gameContract.deployed().then(function(instance) {
//         return instance.registerAsAnOpponent({from: accounts[0]});
//       }).then(function(result) {
//         console.log('Registered as an opponent')
//         getSecondWrestlerAddress();
//       }).catch(function(err) {
//         console.log(err.message);
//       });
//     }
//   }
//   });
// }

// When the page loads, this will call the init() function
$(function() {
  $(window).load(function() {
    init();
  });
});