var blackjack = blackjack || {};

//TODO pass in game id
blackjack.BetFactory = {
  makeBet: function(bet, callback) {
    var myBet = new blackjack.Bet({game_id: 42, amount: bet});
    myBet.save(null, {success: callback});
  }
}
