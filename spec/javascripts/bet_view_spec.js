#= require application

 describe('Tests for Betting', function() {

  it('Should be be a button tag', function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <button type="button">bet</button> </script>');
    var bet = new Bet();
    var view = new BetView();
    $('#bet').click();
    console.log(bet.get('value'));
  });
});
