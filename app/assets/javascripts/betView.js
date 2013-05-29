var BetView = Backbone.View.extend({
  el: '#game',
  events: {
    'click #bet': 'makeBet',
  },
  makeBet: function() {
    var newBet = $("#betInput").val();
    bet.set('value', 3);
    console.log(bet.get('value'));
  }
});
