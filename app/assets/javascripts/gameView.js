var blackjack = blackjack || {};
blackjack.GameView = Backbone.View.extend({
  games: undefined, // assigned from template
  user: undefined,// assigned from template
  CardsView: undefined,

  initialize: function() {
    this.CardsView = new blackjack.CardsView();
  },


  render: function() {
    var source = $("#game-template").html();
    var template = Handlebars.compile(source);
    this.$el.html( template );
    this.CardsView.render(this.games.id);


    if (typeof this.user != 'undefined'){
      var that = this;
      this.user.fetch({success: function(){
        that.$('#userName').text(that.user.get('name') );
        that.$('#creditsLabel').text("Credits: " + that.user.get('credits') );
      }});
    }
  },
  el: '#game',

  events: {
    'click #betButton': 'setBetVariable',
    'click #hitButton': 'hitButtonFunction'
  },

  setBetVariable: function(){
    var bet = $('#betInput').val();
    var that = this;
    this.games.makeBet(parseInt(bet), function() {
      that.render();
    });
  },

  hitButtonFunction: function() {
    this.games.gameHit({success:this.render()});
  }
});
