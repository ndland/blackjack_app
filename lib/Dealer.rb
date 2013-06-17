class Dealer

  attr_accessor :sleeve

  def intialize
    @sleeve = Sleeve.new

  end

  def deal_player_card
    #TODO associate game_id with this method
    newCard = sleeve.get
    PlayerCards.create(suit: newCard[1], faceValue: newCard[0])
  end
end
