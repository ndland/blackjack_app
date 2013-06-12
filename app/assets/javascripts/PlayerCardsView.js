var blackjack = blackjack || {};

blackjack.PlayerCardsView = Backbone.View.extend({
  playerCards: undefined, //TODO initialize me to something?

  initialize: function(){
    // PlayerCardsModel = new blackjack.PlayerCardsModel();
    this.playerCards = new blackjack.PlayerCardsCollection;
    this.playerCards.id = 42;
    this.render();
  },
  render: function (){
    this.playerCards.fetch({success:this.displayCards});
  },
  displayCards: function(){

  }
});
