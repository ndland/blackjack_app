class Dealer

  attr_accessor :sleeve

  def intialize
    @sleeve = Sleeve.new

  end

  def deal_player_card(game_id)
    newCard = sleeve.getCard
    PlayerCards.create(suit: newCard[1], faceValue: newCard[0], game_id: game_id)
  end
end
