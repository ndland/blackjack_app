var blackjack = blackjack || {};

blackjack.WinnersView = Backbone.View.extend({
  winner: undefined,

  initialize: function() {
    this.winner = new blackjack.Winner;
    this.render();

  },

  render: function(game_id) {
    those = this;
    this.winner.id = game_id
    this.winner.fetch({ success: this.displayWinner });
  },

  displayWinner: function() {
    var source = $('#winner-template').html();
    var template = Handlebars.compile(source);
    $('#winner').html(template(those.winner.toJSON()));
    if (those.winner.has("outcome")) {
      $('#betButton').prop('disabled', false);
      $('#betInput').prop('disabled', false);
      $('#hitButton').prop('disabled', true);
      $('#standButton').prop('disabled', true);
    }
  }
})
