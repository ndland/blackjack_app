var BetList = Backbone.Collection.extend({
  model: Bet,
  localStorage: new Backbone.LocalStorage('bet-backbone'),
});

Bets = new BetList();

