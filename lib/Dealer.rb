class Dealer

  attr_accessor :deck

  def intialize
    @deck = Deck.new
  end

  def deal_player_card
    deck.get

  end
end
