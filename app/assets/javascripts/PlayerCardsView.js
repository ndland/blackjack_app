var blackjack = blackjack || {};

blackjack.PlayerCardsView = Backbone.View.extend({
  playerCards: undefined,

  initialize: function(){
    this.playerCards = new blackjack.PlayerCardsCollection;
    this.playerCards.id = 42;
    this.render();
  },
  render: function (){
    this.playerCards.fetch({success:this.displayCards});
  },
  displayCards: function(){
      var source = $("#card-template").html();
      var template = Handlebars.compile(source);

      var context = {cards: this.playerCards.toJSON()};

      $('#cards').html(template(context));

  },
});
