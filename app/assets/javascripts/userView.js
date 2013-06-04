var blackjack = blackjack || {};
blackjack.userView = Backbone.View.extend({
  initialize: function() {
    this.render();
  },
  render: function() {
    // Compile the template using Handlebarls
    var source = $("#game-template").html()
    var template = Handlebars.compile(source);
    // Load the compiled HTML into the Backbone "el"
    this.$el.html( template );
    // this.$('#betLabel').text("Bet: " + myUser.get('name') );
    this.$('#creditsLabel').text("Credits: " + myUser.get('credits') );
    this.$('#levelLabel').text("Level: " + myUser.get('level') );
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
    } else if( newBet > user.get('credits') ) {
      alert("You do not have enough credits to place that bet!");
    }
    else {
     b = new blackjack.Bet();
     b.save();
    };
  },
  changeCredits: function( newBet ) {
    var oldCredits = user.get('credits');
    var newCredits = oldCredits - newBet;
    if (newCredits === 0) {
      newCredits= 100;
    };
    user.set('credits', newCredits);
    this.render();
  }
});
