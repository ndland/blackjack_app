var blackjack = blackjack || {};

blackjack.Winner = Backbone.Model.extend({
  id: undefined,
  url: function() {
    return "/api/game/" + this.id + "/winner";
  }
});

blackjack.Bet = Backbone.Model.extend({
  url: function() {
    return "/api/game/" + this.get("game_id") + "/bet";
  }
});

blackjack.Stand = Backbone.Model.extend({
url: function() {
  return "/api/game/" + this.get("game_id") + "/stand";
}
});

blackjack.Hit = Backbone.Model.extend({
  url: function() {
    return "/api/game/" + this.get("game_id") + "/hit";
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
  },

  gameHit: function(callback) {
    var myHit = new blackjack.Hit({game_id: this.get("id")});
    myHit.save(null, { success: callback });
  },

  gameStand: function(callback) {
    var myStand = new blackjack.Stand({game_id: this.get("id")});
    myStand.save(null, { success: callback });
  }
});

blackjack.PlayerCardsCollection = Backbone.Collection.extend({

  id: undefined,
  url: function() {
    return "/api/game/" + this.id +"/player_cards";
  }
});

blackjack.DealerCardsCollection = Backbone.Collection.extend({

  id: undefined,
  url: function() {
    return "/api/game/" + this.id + "/dealer_cards";
  }
});
