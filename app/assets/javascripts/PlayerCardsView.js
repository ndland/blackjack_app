var blackjack = blackjack || {};

blackjack.PlayerCardsView = Backbone.View.extend({
  playerCards: undefined, //TODO initialize me to something?

  initialize: function(){
   this.playerCards = new blackjack.PlayerCards({game_id: 42});
   this.render();
  },
  render: function (){
    this.playerCards.fetch({success:this.displayCards});
  }
});
