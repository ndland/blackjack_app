var blackjack = blackjack || {};
blackjack.GameView = Backbone.View.extend({
  games: undefined, // assigned from template
  user: undefined,// assigned from template

  initialize: function() {
    this.render();
  },

  render: function() {
    console.log("rendering!!!")
      var source = $("#game-template").html();
      var template = Handlebars.compile(source);
      this.$el.html( template );
    if (typeof this.user != 'undefined'){
      var that = this;
      this.user.fetch({success: function(){
        console.log("updating the user")
        that.$('#userName').text(that.user.get('name') );
        console.log("user has credits" + that.user.get("credits"))
        that.$('#creditsLabel').text("Credits: " + that.user.get('credits') );
      }});
    }
    // this.$('#levelLabel').text("Level: " + myUser.get('level') );
    },
    el: '#game',
    events: {
      'click #betButton': 'setBetVariable'
    },
    setBetVariable: function(){
      var bet = $('#betInput').val();
      var that = this;
      this.games.makeBet(parseInt(bet), function() {
        that.render();
      });
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
