// var source =$("#game-template").html();

var blackjack = blackjack || {};


blackjack.User = Backbone.Model.extend({
  urlRoot:  "/api/user/"
  // initialize: function(){
  //   this.on('change', function(){
  //     // console.log(myUser.get('credits'));
  //     var newLevel = Math.round(myUser.get('credits')/100);
  //     if (newLevel != myUser.get('level')){
  //       myUser.set('level', newLevel);
  //     };
  //   })
  // }
});
