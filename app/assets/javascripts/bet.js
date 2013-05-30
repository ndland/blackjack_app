var source =$("#game-template").html();
var Bet  = Backbone.Model.extend({
  defaults: {
    value: 0
  },

  intialize: function() {
    this.on("change:value", function(model) {
      var value = model.get('value');
      // console.log('value');
    });
  },
});

var bet = new Bet();
