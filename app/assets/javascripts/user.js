// var source =$("#game-template").html();

var blackjack = blackjack || {};

blackjack.Bet = Backbone.Model.extend({
  url: function() {
    return "/api/game/" + this.get("game_id") + "/bet";
  }
});

blackjack.User = Backbone.Model.extend({
  urlRoot:  "/api/user/",
});

blackjack.Game = Backbone.Model.extend({
  defaults: {
    id: undefined
  },
  makeBet: function(bet, callback) {
    var myBet = new blackjack.Bet({game_id: this.get("id"), bet: bet});
    myBet.save(null, {success: callback });
  }
});

blackjack.PlayerCards = Backbone.Model.extend({
  url: function() {
    return "/api/game/" + this.get("game_id") + "/playercards";
  }
});
