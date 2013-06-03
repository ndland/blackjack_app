#= require application

var blackjack = blackjack || {};

describe('Tests for Betting', function() {

  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <button id="betButton">bet</button> <input type="text" id="betInput" size="5"> </script>');
    var myUser = new blackjack.User({id: 19 });
    myUser.fetch({success:function(){ var view = new blackjack.userView();
                 view.initialize();
    }});
    // $('input').val("3");
    myUser.set('credits', 100);
  });
// 
//   it('Should be be a button tag', function() {
//     document.getElementById('betButton').onclick = function() {
//       alert("button was clicked");
//     };
//     $('#betButton').click();
//   });
// 
//   it('Should set the bet to a new value', function() {
//     $('#betButton').click();
//     assert.equal(user.get('value'), 3, 'these values are equal');
//   });
// 
//   it('should display the users bet on the game page', function() {
//     $('#betButton').click();
//     $("body").append('<label id="betLabel">' + user.get('value') + '</label>');
//     var label = $('#betLabel').text();
//     assert.equal( label, 3);
//   });
// 
//   it('should have the correct value of credits', function(){
//     $("body").append("100");
//     assert.equal(user.get('credits'), "100");
//     $('#betButton').click();
//   });
// 
//   it('should display the amount of credits', function() {
//     $('#betButton').click();
//     $("body").append('<label id="creditsLabel">' + user.get('credits') + '</label>');
//     var label = $('#creditsLabel').text();
//     assert.equal( label, 97);
//   });
// 
//   it('should not allow negative bets', function(){
//     $("body").append('<label id="creditsLabel">' + user.get('credits') + '</label>');
//     $('input').val("-3");
//     $('#betButton').click();
//     var label = $('#creditsLabel').text();
//     console.log( label );
//     assert.equal( label, 100);
//   });
// 
//   it('Should replenish the users credits when they get to 0', function() {
//     user.set('credits', 10);
//     $("body").append('<label id="creditsLabel">' + user.get('credits') + '</label>');
//     $('input').val("10");
//     $('#betButton').click();
//     assert.equal( user.get('credits'), "100");
//   });
// 
//   it('should not allow you to bet more credits than you currently have', function() {
//     $("body").append('<label id="creditsLabel">' + user.get('credits') + '</label>');
//     $('input').val("110");
//     $('#betButton').click();
//     assert.equal( user.get('credits'), "100");
//   });
// 
  it('should display the correct level', function(){
    $("body").append('<label id="levelLabel">' + user.get('level') + '</label>');
    // $('#betButton').click();
    assert.equal( myUser.get('level'), "1");
    myUser.set('credits', 550);
    // $('#betButton').click();
    assert.equal( myUser.get('level'), "6");
  })
});
