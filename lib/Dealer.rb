class Dealer

  attr_accessor :deck

  def intialize
    @deck = Deck.new

  end

  def deal_player_card
    newCard = deck.get
    PlayerCards.create(suit: newCard[1], faceValue: newCard[0])
  end
end
