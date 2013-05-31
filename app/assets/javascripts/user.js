var source =$("#game-template").html();
var User  = Backbone.Model.extend({
  defaults: {
    value: 0,
    credits: 100,
    level: 1
  },

  intialize: function() {
    console.log('hello');
    this.on('change', function() {
      console.log('hi');
      if (credits === 0) {
        this.set('credits', 100);
      };
    });
  },
});

var user = new User();
