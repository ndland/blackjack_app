var blackjack = blackjack || {};
blackjack.GameView = Backbone.View.extend({
  games: undefined, // assigned from template
  user: undefined,// assigned from template
  CardsView: undefined,
  WinnersView: undefined,

  initialize: function() {
    var source = $("#game-template").html();
    var template = Handlebars.compile(source);
    this.$el.html( template );
    this.CardsView = new blackjack.CardsView();
    $('#hitButton').prop('disabled', true);
    $('#standButton').prop('disabled', true);
  },


  render: function() {
    this.CardsView.render(this.games.id);
    this.WinnersView = new blackjack.WinnersView();
    this.WinnersView.render(this.games.id);

    // this.$('#betInput').val('');

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
    'click #hitButton': 'hitButtonFunction',
    'click #standButton': 'standButtonFunction'
  },

  setBetVariable: function(){
    var bet = $('#betInput').val();
    var that = this;
    this.games.makeBet(parseInt(bet), function() {
      that.render();
      $('#betButton').prop('disabled', true);
      $('#hitButton').prop('disabled', false);
      $('#standButton').prop('disabled', false);
    });
  },

  hitButtonFunction: function() {
    var that = this;
    this.games.gameHit(function() {
      that.render();
    });
  },

  standButtonFunction: function() {
    var that = this;
    this.games.gameStand(function() {
      that.render();
      $('#betButton').prop('disabled', false)
      $('#hitButton').prop('disabled', true);
      $('#standButton').prop('disabled', true);
    });
  }
});
