#= require application

describe('Bet', function(){
     var bet = new Bet();
  it ('should get a default value of 0', function() {
      expect(bet.get('value')).to.eq(0);
  });

  it ('should be able to set a bet', function() {
     bet.set('value', 1);
     expect(bet.get('value')).to.eq(1);
  });
});

