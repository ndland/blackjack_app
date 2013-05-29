var BetView = Backbone.View.extend({
  initialize: function(){
    this.render();
  },
  render: function(){
    // Compile the template using Handlebarls
    var source = $("#game-template").html();
    var template = Handlebars.compile(source);
    // Load the compiled HTML into the Backbone "el"
    this.$el.html( template );
  },
  el: '#game',
  events: {
    'click #bet': 'makeBet'
  },
  makeBet: function() {
   // var newBet = $("#betInput").val();
   bet.set('value', 3);
   console.log(bet.get('value'));
  }
});
