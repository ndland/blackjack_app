#= require application

var blackjack = blackjack || {};

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

  it("should make a call to the web server", function(done) {
    callback = function() {
      done();
    }

    this.server.respondWith("POST", "/api/game/42/bet",
                            [200, { "Content-Type": "application/json"}, '{}']
                           );
   var myGame = new blackjack.Game({ id: 42 });
   myGame.makeBet(500, callback);
  });

  it("should set the bet amount to the web server", function(done) {
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

describe("Game View", function() {
  beforeEach( function() {
    $("body").append('<section id = "game"> </section>');
    $("body").append('<script id="game-template" type="text/x-handlebars-template"> <button id="betButton">bet</button> <input type="text" id="betInput" size="5">  </script>');

    this.server = sinon.fakeServer.create();
    this.server.autoRespond = true

    myGame = new blackjack.Game({id: 42});
    myUser = new blackjack.User({id: 19});
    view = new blackjack.GameView();
    view.user = myUser;
    view.CardsView = {render: function(){}}

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
    it("should call for a update on the usermodel whenever gameView is rendered ", function() {
      //setup
      this.subject.user.fetch = sinon.spy()

      //invoke
      view.games = myGame
      view.render();

      //expectations
      sinon.assert.calledOnce(this.subject.user.fetch)
    });
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
