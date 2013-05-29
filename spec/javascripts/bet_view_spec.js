#= require application
#= require app/views/game/show.html.erb

describe('Tests for Betting', function() {

   $('body').append('<section id="game"></section>')
  var view = new BetView();

  it('Should be be a button tag', function() {
    $('#bet').click();
    console.log(bet.get('value'));
  });
});
