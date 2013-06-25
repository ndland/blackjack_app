var blackjack = blackjack || {};

blackjack.CardsView = Backbone.View.extend({
  playerCards: undefined,
  dealerCards: undefined,

  initialize: function(){
    this.playerCards = new blackjack.PlayerCardsCollection;
    this.dealerCards = new blackjack.DealerCardsCollection;
    this.render();
  },
  render: function (id){
    this.playerCards.id = id;
    this.dealerCards.id = id;
    that = this;
    this.playerCards.fetch({success:this.displayCards});
    this.dealerCards.fetch({success:this.displayCards});
  },
  displayCards: function(){
    var source = $("#card-template").html();
    var template = Handlebars.compile(source);
    var playerCardscontext = {cards: that.playerCards.toJSON()};
    var dealerCardsContext = {cards: that.dealerCards.toJSON()};

    $('#playerCards').html(template(playerCardscontext));
    $('#dealerCards').html(template(dealerCardsContext));

  },
});
