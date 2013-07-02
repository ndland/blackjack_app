#= require application

var blackjack = blackjack || {};
describe("Game View", function() {
  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <button id="standButton">stand</button> <button id="hitButton">hit</button> <button id="betButton">bet</button> <input type="text" id="betInput" size="5">  </script>');

    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true

    myGame = new blackjack.Game({id: 42});
    myUser = new blackjack.User({id: 19});
    view = new blackjack.GameView();
    view.user = myUser;
    view.CardsView = {render: function(){}}
    view.WinnersView = {render: function(){}}

    this.subject = view;
  });

  afterEach( function() {
    this.server.restore();
  });


  it("initializes the players card view", function () {
    var newGameView = new blackjack.GameView();
    expect(newGameView.CardsView).to.exist
  });

  it("initializes the playersCardView to a blackjack.CardsView", function() {
    var newGameView = new blackjack.GameView();
    expect(newGameView.CardsView).to.be.instanceOf(blackjack.CardsView);
  });

  it("should call the setBetVariable function when the button is clicked", function () {
    view.games = myGame
    view.CardsView = {render: function() {}}

    view.render();

    view.setBetVariable = sinon.spy()
    view.delegateEvents()

    $('#betButton').click();

    sinon.assert.calledOnce(view.setBetVariable)
  });

  describe("#render", function() {
    it("initializes the winners view", function() {
      view.games = myGame
      view.render();
      expect(view.WinnersView).to.exist
    });

  it("initializes the winnersView to a blackjack.WinnersView", function() {
      view.games = myGame
      view.render();
      expect(view.WinnersView).to.be.instanceOf(blackjack.WinnersView);
  });

    it("should call for a update on the usermodel whenever gameView is rendered", function() {
      //setup
      this.subject.user.fetch = sinon.spy()

      //invoke
      view.games = myGame
      view.render();

      //expectations
      sinon.assert.calledOnce(this.subject.user.fetch)
    });

    it("should render the player cards", function() {
      var myGame = new blackjack.Game({id: 42});
      var myUser = new blackjack.User({id: 19});
      var view = new blackjack.GameView();

      view.games = myGame
      view.CardsView = {render: function() {}}

      view.CardsView.render = sinon.spy();
      view.render();

      sinon.assert.calledOnce(view.CardsView.render)
    });

    it("should pass the game id to the player cards", function() {
      var myGame = new blackjack.Game({id: 42});
      var myUser = new blackjack.User({id: 19});
      var view = new blackjack.GameView();

      view.games = myGame
      view.CardsView = {render: function() {}}

      view.CardsView.render = sinon.spy();
      view.render();

      assert(view.CardsView.render.calledWith(view.games.id))
    });

    it("disables the hit button, until the bet is placed", function() {
      view.games = myGame;
      expect($('#hitButton').is(':disabled')).to.be.true
    });

    it("re-enables the hit button after the bet is placed", function() {
      view.games = myGame;
      var betResponse= sinon.stub();
      view.games.makeBet = betResponse;
      betResponse.callsArg(1);
      view.setBetVariable();
      expect($('#hitButton').is(':disabled')).to.be.false
    });

    it("disables the stand button, until the bet is placed", function() {
      view.games = myGame;
      expect($('#standButton').is(':disabled')).to.be.true
    });

    it("re-enables the stand button after the bet is placed", function() {
      view.games = myGame;
      var betResponse= sinon.stub();
      view.games.makeBet = betResponse;
      betResponse.callsArg(1);
      view.setBetVariable();
      expect($('#standButton').is(':disabled')).to.be.false
    });

    // TODO: figure out how to test this or  if creating a new view is even correct
    // it("should render the winners view", function() {
    //   var myGame = new blackjack.Game({id: 42});
    //   var myUser = new blackjack.User({id: 19});
    //   var view = new blackjack.GameView();

    //   view.games = myGame
    //   view.CardsView = {render: function() {}}
    //   view.WinnersView = {render: function() {}}

    //   view.WinnersView.render = sinon.spy();
    //   view.render();

    //   sinon.assert.calledOnce(view.WinnersView.render)
    // });

    // it("should pass the game id to winners view", function() {
    //   var myGame = new blackjack.Game({id: 42});
    //   var myUser = new blackjack.User({id: 19});
    //   var view = new blackjack.GameView();

    //   view.games = myGame
    //   view.CardsView = {render: function() {}}
    //   view.WinnersView = {render: function() {}}

    //   view.WinnersView.render = sinon.spy();
    //   view.render();

    //   assert(view.WinnersView.render.calledWith(view.games.id))
    // });
  });

  describe("#BetButton", function(){

    it("should call the makeBet function when the setBetVariable function is executed", function() {
      var myGame = new blackjack.Game({id: 42});
      var betFactoryMock = sinon.mock(myGame);
      var myUser = new blackjack.User({id: 19});
      var view = new blackjack.GameView();
      view.games = myGame;
      view.user = myUser;
      view.CardsView = {render: function() {}}
      view.render()
      betFactoryMock.expects("makeBet").withArgs(110).once();

      $('#betInput').val("110");
      view.setBetVariable();

      betFactoryMock.verify()
    });

    it("disables after a successful bet", function() {
      view.games = myGame;
      var betResponse= sinon.stub();
      view.games.makeBet = betResponse;
      betResponse.callsArg(1);
      view.setBetVariable();
      expect($('#betButton').is(':disabled')).to.be.true
    });

    it("doesn't disable when a bet is unsuccessful", function() {
      view.games = myGame;
      view.setBetVariable();
      expect($('#betButton').is(':disabled')).to.be.false
    });
  });

  describe("#StandButton", function(){
    it ("should call the standButtonfunction", function() {
      view.games = myGame
      view.CardsView = {render:function() {}}

      view.render();
      $('#standButton').prop('disabled', false);

      view.standButtonFunction = sinon.spy();
      view.delegateEvents();
      $('#standButton').click();
      sinon.assert.calledOnce(view.standButtonFunction);
    });

    it("should call the gameStand function when the standButtonFunction is executed", function() {
      var myGame = new blackjack.Game({id: 42});
      var standFactoryMock = sinon.mock(myGame);
      var myUser = new blackjack.User({id: 19});
      var view = new blackjack.GameView();
      view.games = myGame;
      view.user = myUser;
      view.CardsView = {render: function() {}}
      view.render();
      standFactoryMock.expects("gameStand").once();
      view.standButtonFunction();

      standFactoryMock.verify();
    });

    it("re-enables the bet button", function() {
      view.games = myGame;
      var betResponse= sinon.stub();
      view.games.gameStand = betResponse;
      betResponse.callsArg(0);
      view.render();
      $('#betButton').prop('disabled', true);
      view.standButtonFunction();
      expect($('#betButton').is(':disabled')).to.be.false
    });
  });

  describe("#HitButton", function() {
    it ("should call the hitButtonfunction", function() {
      view.games = myGame
      view.CardsView = {render:function() {}}

      view.render();
      $('#hitButton').prop('disabled', false);

      view.hitButtonFunction = sinon.spy();
      view.delegateEvents();
      $('#hitButton').click();
      sinon.assert.calledOnce(view.hitButtonFunction);
    });

    it("should call the gameHit function when the hitButtonFunction is executed", function() {
      var myGame = new blackjack.Game({id: 42});
      var hitFactoryMock = sinon.mock(myGame);
      var myUser = new blackjack.User({id: 19});
      var view = new blackjack.GameView();
      view.games = myGame;
      view.user = myUser;
      view.CardsView = {render: function() {}}
      view.render();
      hitFactoryMock.expects("gameHit").once();
      view.hitButtonFunction();

      hitFactoryMock.verify();
    });

    //TODO - ask tony
    // it("hitButtonFunction re-renders the page once it gets a callback", function(){
    //    var myGame = new blackjack.Game({id: 42});
    //    var myUser = new blackjack.User({id: 19});
    //    var view = new blackjack.GameView();
    //    view.games = myGame;
    //    view.user = myUser;
    //    view.games.gameHit = sinon.stub().returns();
    //    view.render = sinon.spy()

    //    //invoke
    //    view.hitButtonFunction();


    //    //expect
    //    sinon.assert.calledOnce(view.render);
    // });
  });
});

describe("WinnersView", function() {
  beforeEach(function() {
    this.subject = new blackjack.WinnersView();
  });

  it("exists", function () {
    expect(this.subject).to.exist;
  });

  it("creates a Winners model when initialized is called", function() {
    expect(this.subject.winner).to.not.be.undefined;
  });

  it("has a render function", function() {
    expect (this.subject.render).to.exist;
  });

  it("calls the render function", function(){
    this.subject.render = sinon.spy();
    this.subject.initialize();

    sinon.assert.calledOnce(this.subject.render);
  });

  describe("#render function", function() {

    it("should set the id for the winner model", function() {
      this.subject.winner = new blackjack.Winner;

      this.subject.render(52);

      assert.equal(this.subject.winner.id, 52);
    });

    it("should call for a update on the Winner model whenever winnerView is rendered", function() {
      //setup
      this.subject.winner.fetch = sinon.spy();

      //invoke
      this.subject.render();

      //expectations
      sinon.assert.calledOnce(this.subject.winner.fetch);
    });

    it("should use the winners model to display the winner", function() {

      var winnerStub = sinon.stub();
      this.subject.winner.fetch = winnerStub;
      this.subject.displayWinner = sinon.spy();

      this.subject.render();
      winnerStub.getCall(0).args[0].success();

      sinon.assert.calledOnce(this.subject.displayWinner);
    });
  });

  describe("#display function", function(){

    it("should exist", function() {
      expect(this.subject.displayWinner).to.exist;
    });

    it("should display the winner of the hand if player wins", function() {
      $("body").append('<section id = "winner"></section>');
      $("body").append('<script id = "winner-template" type="text/x-handlebars-template"> <div id="winner">{{this.outcome}}</div> </script>');
      this.subject.winner = new Backbone.Model();
      this.subject.winner
      .set({outcome: "Player Wins"});

      this.subject.displayWinner();

      var winner = $('#winner').text();
      assert.equal(winner, ' Player Wins ');
    });

    it("should display the winner of the hand if dealer wins", function() {
      $("body").append('<section id = "winner"></section>');
      $("body").append('<script id = "winner-template" type="text/x-handlebars-template"> <div id="winner">{{this.outcome}}</div> </script>');
      this.subject.winner = new Backbone.Model();
      this.subject.winner
      .set({outcome: "Dealer Wins"});

      this.subject.displayWinner();

      var winner = $('#winner').text();
      assert.equal(winner, ' Dealer Wins ');
    });
  });
});


describe("CardsView", function() {
  beforeEach(function() {
    this.subject = new blackjack.CardsView();
  });

  it("exists", function () {
    expect(this.subject).to.exist;
  });

  it ("creates a player cards collection  when initialized is called", function(){
    expect(this.subject.playerCards).to.not.be.undefined;
  });

  it ("creates a dealers cards collection  when initialized is called", function(){
    expect(this.subject.dealerCards).to.not.be.undefined;
  });

  it("calls the render function", function(){
    this.subject.render = sinon.spy();
    this.subject.initialize();

    sinon.assert.calledOnce(this.subject.render);
  });

  describe("#render", function() {
    beforeEach(function() {
      this.subject.playerCards = {fetch: function(){}};
    });

    it("fetches the player cards from the server", function () {
      //setup
      this.subject.playerCards.fetch = sinon.spy();

      //invoke
      this.subject.render();

      //expect
      sinon.assert.calledOnce(this.subject.playerCards.fetch);
    });

    it("fetches the dealer cards from the server", function () {
      //setup
      this.subject.dealerCards.fetch = sinon.spy();

      //invoke
      this.subject.render();

      //expect
      sinon.assert.calledOnce(this.subject.dealerCards.fetch);
    });

    it("uses the fetched player cards to display them", function () {
      //setup
      var fetchStub = sinon.stub()
      this.subject.playerCards.fetch = fetchStub;
      this.subject.displayCards = sinon.spy()

      //invoke
      this.subject.render();

      fetchStub.getCall(0).args[0].success();

      //expect
      sinon.assert.calledOnce(this.subject.displayCards);
    })

    it("uses the fetched dealer cards to display them", function () {
      //setup
      var fetchStub = sinon.stub()
      this.subject.dealerCards.fetch = fetchStub;
      this.subject.displayCards = sinon.spy()

      //invoke
      this.subject.render(42);

      fetchStub.getCall(0).args[0].success();

      //expect
      sinon.assert.calledOnce(this.subject.displayCards);
    })

    it("sets the game id to the dealerCards & playerCards variables", function () {
      this.subject.playerCards = new blackjack.PlayerCardsCollection;
      this.subject.dealerCards = new blackjack.DealerCardsCollection;
      this.subject.render(42);
      assert.equal(this.subject.playerCards.id, 42);
      assert.equal(this.subject.dealerCards.id, 42);
    });
  });


  describe("#displaying", function() {

    it("cards should exist", function() {
      expect(this.subject.displayCards).to.exist;
    });

    it("should display a players card", function() {
      //setup
      $("body").append('<section id = "playerCards"> </section>');
      $("body").append('<script id="card-template" type="text/x-handlebars-template">{{#each cards}} <div id="card" >{{this.faceValue}} {{this.suit}}</div>{{/each}}</script>');
      this.subject.playerCards = new Backbone.Collection();
      this.subject.playerCards
      .add ({ suit: 'c', faceValue: 1 })

      //invoke
      this.subject.displayCards();

      //expect
      var suit = $('#card').text();
      assert.equal(suit , '1 c');
    });

    it("should display a dealers card", function() {
      $("body").append('<section id = "dealerCards"> </section>');
      $("body").append('<script id="card-template" type="text/x-handlebars-template">{{#each cards}} <div id="card" >{{this.faceValue}} {{this.suit}}</div>{{/each}}</script>');
      this.subject.dealerCards = new Backbone.Collection();
      this.subject.dealerCards
      .add ({ suit:'c', faceValue: 1 })

      this.subject.displayCards();

      var suit =  $('#card').text();
      assert.equal(suit, '1 c');

    });

    it("should display all cards", function() {
      //setup
      $("body").append('<section id = "playerCards"> </section>');

      $("body").append('<script id="card-template" type="text/x-handlebars-template"><label id="all">{{#each cards}} <div id="card" >{{this.faceValue}} {{this.suit}}</div>{{/each}}</label></script>');

      this.subject.playerCards = new Backbone.Collection();
      this.subject.playerCards
      .add({ suit: 'c', faceValue: 1 })
      .add({ suit: 'b', faceValue: 1 })
      .add({ suit: 'a', faceValue: 1 })

      //invoke
      this.subject.displayCards();

      //expect
      assert.equal($('#all').text(), ' 1 c 1 b 1 a');
    });
  });

  it("should display all dealers cards", function() {
    //setup
    $("body").append('<section id = "dealerCards"> </section>');

    $("body").append('<script id="card-template" type="text/x-handlebars-template"><label id="all">{{#each cards}} <div id="card" >{{this.faceValue}} {{this.suit}}</div>{{/each}}</label></script>');

    this.subject.dealerCards = new Backbone.Collection();
    this.subject.dealerCards
    .add({ suit: 'c', faceValue: 1 })
    .add({ suit: 'b', faceValue: 1 })
    .add({ suit: 'a', faceValue: 1 })

    //invoke
    this.subject.displayCards();

    //expect
    assert.equal($('#all').text(), ' 1 c 1 b 1 a');
  });
});

describe("Player Cards Collection", function() {
  beforeEach(function() {
    this.subject = new blackjack.PlayerCardsCollection();
    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it("exists", function() {
    expect(this.subject).to.exist;
  });

  it("accesses /api/game/42/playercards", function(done) {

    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/game/42/player_cards",
                            [200, { "Content-Type": "application/json"}, '{}']);

                            this.playerCards = new blackjack.PlayerCardsCollection;

                            this.playerCards.id = 42;
                            this.playerCards.fetch({success: callback});
  });

  it("accesses /api/game/43/playercards dynamically", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/game/43/player_cards",
                            [200, { "Content-Type": "application/json"}, '{}']);

                            var playerCards = new blackjack.PlayerCardsCollection;

                            playerCards.id =  43;
                            playerCards.fetch({success: callback});
  });
});
describe("Dealer Cards Collection", function() {
  beforeEach(function() {
    this.subject = new blackjack.DealerCardsCollection();
    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it("exists", function() {
    expect(this.subject).to.exist;
  });

  it("accesses /api/game/42/dealer_cards", function(done) {

    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/game/42/dealer_cards",
                            [200, { "Content-Type": "application/json"}, '{}']);

                            this.dealerCards = new blackjack.DealerCardsCollection;

                            this.dealerCards.id = 42;
                            this.dealerCards.fetch({success: callback});
  });

  it("accesses /api/game/43/dealer_cards dynamically", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/game/43/dealer_cards",
                            [200, { "Content-Type": "application/json"}, '{}']);

                            var dealerCards = new blackjack.DealerCardsCollection;

                            dealerCards.id =  43;
                            dealerCards.fetch({success: callback});
  });
});

describe("User Model", function() {
  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<section id = "controls"> </section>');
    $("body").append('<script id="controls-template" type="text/x-handlebars-template"> <button id="betButton">bet</button> <input type="text" id="betInput" size="5">  </script>');
    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it('the User model accesses /api/user/19', function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/user/19",
                            [200, { "Content-Type": "application/json"},
                              '{"credits":100,"id":19,"level":1,"name":"User_1"}'] );

                              var myUser = new blackjack.User( {id: 19 } );
                              myUser.fetch({success: callback});
  });
});

describe ("Stand Model", function() {

  beforeEach( function() {
    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it("exists", function() {
    var myStand = new blackjack.Stand();
  });

  it("accesses /api/game/42/stand", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("POST", "/api/game/42/stand",
                            [200, { "Content-Type": "application/json"}, '{}'] );

                            var myStand = new blackjack.Stand({game_id: 42});
                            myStand.save(null, {success: callback});
  });

  it("should make a call to the web server through gameStand", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("POST", "/api/game/42/stand",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
                           var myGame = new blackjack.Game({ id: 42 });
                           myGame.gameStand(callback);
  });

  it("should set the game id", function(done) {
    var that = this;

    callback = function() {
      var game_id = that.server.requests[0].requestBody;
      expect(game_id).to.equal('{"game_id":43}');
      done();
    }
    this.server.respondWith("POST", "/api/game/43/stand",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
                           var myGame = new blackjack.Game({ id: 43 });
                           myGame.gameStand(callback);
  });
});

describe ("Hit Model", function() {

  beforeEach( function() {
    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it("exists", function() {
    var myHit = new blackjack.Hit();
  });

  it("accesses /api/game/42/hit", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("POST", "/api/game/42/hit",
                            [200, { "Content-Type": "application/json"}, '{}'] );

                            var myHit = new blackjack.Hit({game_id: 42});
                            myHit.save(null, {success: callback});
  });

  it("should make a call to the web server through gameHit", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("POST", "/api/game/42/hit",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
                           var myGame = new blackjack.Game({ id: 42 });
                           myGame.gameHit(callback);
  });

  it("should set the game id", function(done) {
    var that = this;

    callback = function() {
      var game_id = that.server.requests[0].requestBody;
      expect(game_id).to.equal('{"game_id":43}');
      done();
    }
    this.server.respondWith("POST", "/api/game/43/hit",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
                           var myGame = new blackjack.Game({ id: 43 });
                           myGame.gameHit(callback);
  });
});

describe("Bet Model", function() {

  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <button id="betButton">bet</button> <input type="text" id="betInput" size="5">  </script>');

    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it("the Bet model access /api/game/42/bet", function (done) {
    callback = function() {
      done();
    }

    this.server.respondWith("POST", "/api/game/42/bet",
                            [200, { "Content-Type": "application/json"}, '{}'] );

                            var myBet = new blackjack.Bet({game_id: 42, amount: 300});
                            myBet.save(null, {success: callback});
  });

  it("should make a call to the web server through makeBet", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("POST", "/api/game/42/bet",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
                           var myGame = new blackjack.Game({ id: 42 });
                           myGame.makeBet(500, callback);
  });

  it("makeBet should set the bet amount to the web server", function(done) {
    var that = this

    callback = function() {
      var betElement = that.server.requests[0].requestBody;
      expect(betElement).to.equal('{"game_id":42,"bet":500}');
      done();
    }

    this.server.respondWith("POST", "/api/game/42/bet",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );

                           var myGame = new blackjack.Game ({id: 42});
                           myGame.makeBet(500, callback);
  });
});

describe("Winner Model", function() {

  beforeEach( function() {
    this.subject = new blackjack.Winner();
    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true
  });

  afterEach( function() {
    this.server.restore();
  });

  it("exists", function() {
    var winner = new blackjack.Winner();
  });

  it("accesses /api/game/42/winner", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/game/42/winner",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
                           this.winner = new blackjack.Winner;
                           this.winner.id = 42;
                           this.winner.fetch({success: callback});
  });

  it("accesses /api/game/21/winner", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("GET", "/api/game/21/winner",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
                           this.winner = new blackjack.Winner;
                           this.winner.id = 21;
                           this.winner.fetch({success: callback});
  });
});

