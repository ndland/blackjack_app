#= require application

describe('Tests for Betting', function() {

  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <button id="betButton">bet</button> <input type="text" id="betInput" size="5"> </script>');
    var view = new BetView();
    $('input').val("3");
    bet.set('credits', 100);
  });

  it('Should be be a button tag', function() {
    document.getElementById('betButton').onclick = function() {
      alert("button was clicked");
    };
    $('#betButton').click();
  });
  it('Should set the bet to a new value', function() {
    $('#betButton').click();
    assert.equal(bet.get('value'), 3, 'these values are equal');
  });
  it('should display the users bet on the game page', function() {
    $('#betButton').click();
    $("body").append('<label id="betLabel">' + bet.get('value') + '</label>');
    var label = $('#betLabel').text();
    assert.equal( label, 3);
  });
  it('should have the correct value of credits', function(){
    $("body").append("100");
    assert.equal(bet.get('credits'), "100");
  })
  it('should display the amount of credits', function() {
    $('#betButton').click();
    $("body").append('<label id="creditsLabel">' + bet.get('credits') + '</label>');
    var label = $('#creditsLabel').text();
    assert.equal( label, 97);
  });
  it('should not allow negative bets', function(){
    $("body").append('<label id="creditsLabel">' + bet.get('credits') + '</label>');
    $('input').val("-3");
    $('#betButton').click();
    var label = $('#creditsLabel').text();
    console.log( label );
    assert.equal( label, 100);
  });
  // it('Should change the value of the coins', function() {

  // });
});
