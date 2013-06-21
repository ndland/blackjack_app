class Dealer

  attr_accessor :card

  def intialize
    @card = Card.new

  end

  def deal_player_card(game_id)
    newCard = @card.get_card
    PlayerCards.create(suit: newCard[1], faceValue: newCard[0], game_id: game_id)
  end
end
