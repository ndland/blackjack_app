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
