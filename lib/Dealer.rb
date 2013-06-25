class Dealer

  attr_accessor :card

  def initialize
    @card = Card.new
  end

  def deal_player_card(game_id)
    newCard = card.get_card
    PlayerCards.create(suit: newCard.suit, faceValue: newCard.faceValue, game_id: game_id)
  end
end
