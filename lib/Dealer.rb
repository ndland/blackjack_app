class Dealer

  attr_accessor :card

  def initialize
    @card = Card.new
  end

  def deal_player_card(game_id)
    newCard = card.get_card
    PlayerCards.create(suit: newCard.suit, faceValue: newCard.faceValue, game_id: game_id)
  end

  def deal_dealer_card(game_id)
    newCard = card.get_card
    DealerCards.create(suit: newCard.suit, faceValue: newCard.faceValue, game_id: game_id)
  end

  def play(game_id)
    @cards  = DealerCards.find(:all, conditions:{game_id: game_id});
    faceValue_total(@cards)
  end

  def faceValue_card(card)
    case card.faceValue
    when 'A'
      1
    when '0'..'9'
      card.faceValue.to_i
    else
      10
    end
  end

  def faceValue_total(cards)
    total = cards.
      map{|card| faceValue_card(card) }.
      inject(:+)

    if total < 12  and cards.map(&:faceValue).include?("A")
      total += 10
    end

    return  total
  end
end
