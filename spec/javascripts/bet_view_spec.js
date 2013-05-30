#= require application

describe('Tests for Betting', function() {

  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <label id="betLabel">{{bet.value}}</label> <button id="betButton">bet</button> <input type="text" id="betInput" size="5"> </script>');
    var view = new BetView();
  });

  it('Should be be a button tag', function() {
    document.getElementById('betButton').onclick = function() {
      alert("button was clicked");
    };
    $('#betButton').click();
  });
  it('Should set the bet to a new value', function() {
    $('input').val("3");
    $('#betButton').click();
    assert.equal(bet.get('value'), 3, 'these values are equal');
  });
  it('should display the users bet on the game page', function() {
    $('input').val("3");
    $('#betButton').click();
    console.log(bet.value);
    var label = $('#betLabel').text();
    assert.equal( label, 3);
  });
});
