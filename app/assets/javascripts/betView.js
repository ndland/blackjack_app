var BetView = Backbone.View.extend({
  initialize: function() {
    this.render();
  },
  render: function() {
    // Compile the template using Handlebarls
    var source = $("#game-template").html()
    var template = Handlebars.compile(source);
    // Load the compiled HTML into the Backbone "el"
    this.$el.html( template );
    this.$('#betLabel').text("Bet: " + bet.get('value') );
    this.$('#creditsLabel').text("Credits " + bet.get('credits') );
  },
  el: '#game',
  events: {
    'click #betButton': 'makeBet'
  },
  makeBet: function() {
    var newBet = $("#betInput").val();
    if ( newBet < 0 ) {
      alert("Bet must be positive");
      this.render();
    } else {
      bet.set('value', newBet);
      this.changeCredits( newBet );
    };
    //this.render();
  },
  changeCredits: function( newBet ) {
    var oldCredits = bet.get('credits');
    var newCredits = oldCredits - newBet;
    bet.set('credits', newCredits);
    this.render();
  }
});
