var blackjack = blackjack || {};
blackjack.GameView = Backbone.View.extend({
  game: undefined, // assigned from template
  user: undefined,// assigned from template

  initialize: function() {
    this.render();
  },
  render: function() {
    var source = $("#game-template").html()
    var template = Handlebars.compile(source);
    this.$el.html( template );
    this.user.fetch();
    // this.$('#betLabel').text("Bet: " + myUser.get('name') );
    // this.$('#creditsLabel').text("Credits: " + myUser.get('credits') );
    // this.$('#levelLabel').text("Level: " + myUser.get('level') );
  },
  el: '#game',
  events: {
    'click #betButton': 'setBetVariable'
  },
  setBetVariable: function(callback){
    var bet = $('#betInput').val();
    this.game.makeBet(parseInt(bet))
    // this.betFactory.makeBet(parseInt(bet))
  },
  changeCredits: function( newBet ) {
    var oldCredits = user.get('credits');
    var newCredits = oldCredits - newBet;
    if (newCredits === 0) {
      newCredits= 100;
    };
    user.set('credits', newCredits);
    this.render();
  }
});
