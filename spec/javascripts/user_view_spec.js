#= require application

var blackjack = blackjack || {};

describe('Tests for Betting', function() {
  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <button id="betButton">bet</button> <input type="text" id="betInput" size="5">  </script>');
    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it ('the User model accesses /api/user/19', function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/user/19",
                            [200, { "Content-Type": "application/json"},
                              '{"credits":100,"id":19,"level":1,"name":"User_1"}']
                           );

    var myUser = new blackjack.User( {id: 19 } );
    myUser.fetch({success: callback});
  });

  it ("the Bet model access /api/game/42/bet", function (done) {
    callback = function() {
      done();
    }
    this.server.respondWith("POST", "/api/game/42/bet",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );

    var myBet = new blackjack.Bet({game_id: 42, amount: 300});
    myBet.save(null, {success: callback});
  });

  it ("should call the setBetVariable function when the button is clicked", function () {
    var myGame = new blackjack.Game({id: 42});
    var myUser = new blackjack.User({id: 19});
    var view = new blackjack.GameView();
    view.game = myGame;
    view.user = myUser;
    view.initialize();
    view.setBetVariable = sinon.spy()
    view.delegateEvents()

    $('#betButton').click();

    sinon.assert.calledOnce(view.setBetVariable)
  });

  it ("should call the makeBet function when the setBetVariable function is executed", function() {
    var myGame = new blackjack.Game({id: 42});
    var betFactoryMock = sinon.mock(myGame);
    var myUser = new blackjack.User({id: 19});
    var view = new blackjack.GameView();
    view.game = myGame;
    view.user = myUser;
    view.initialize();
    betFactoryMock.expects("makeBet").withArgs(110).once();

    $('#betInput').val("110");
    view.setBetVariable(callback);

    betFactoryMock.verify()
   });

  it ("should make a call to the web server", function(done) {
    callback = function() {
      done();
    }
    this.server.respondWith("POST", "/api/game/42/bet",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
   var myGame = new blackjack.Game({ id: 42 });
   myGame.makeBet(500, callback);
  });

  it ("should set the bet amount to the web server", function(done) {
    var that = this

    callback = function() {
      var betElement = that.server.requests[0].requestBody;
      expect(betElement).to.equal('{"game_id":42,"amount":500}');
      done();
    }

    this.server.respondWith("POST", "/api/game/42/bet",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );

    var myGame = new blackjack.Game ({id: 42});
    myGame.makeBet(500, callback);
  });
});
