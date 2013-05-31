var source =$("#game-template").html();
var Bet  = Backbone.Model.extend({
  defaults: {
    value: 0,
    credits: 100,
  },

  intialize: function() {
    this.on("change:value", function(model) {
      var value = model.get('value');
    });
  },
});

var bet = new Bet();
