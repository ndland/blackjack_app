var blackjack = blackjack || {};

blackjack.PlayerCardsView = Backbone.View.extend({
  playerCards: undefined,

  initialize: function(){
    this.playerCards = new blackjack.PlayerCardsCollection;
    this.playerCards.id = myGame.game_id;
    this.render();
  },
  render: function (id){
    this.playerCards.id = id;
    that = this;
    this.playerCards.fetch({success:this.displayCards});
  },
  displayCards: function(){
    var source = $("#card-template").html();
    var template = Handlebars.compile(source);
    var context = {cards: that.playerCards.toJSON()};

    $('#cards').html(template(context));

  },
});
