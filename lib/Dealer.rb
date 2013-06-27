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

  def faceValue_total(cards)
    i = 0
    total = 0
    number_of_aces = 0

    until i == cards.count

      if (2..9) === cards[i].faceValue.to_i
        total += cards[i].faceValue.to_i

      elsif cards[i].faceValue == "A"
        number_of_aces += 1
        total += 1
      else
        total+= 10
      end
      i += 1
    end

    if number_of_aces != 0 and total < 12
      total += 10
    end
    return total
  end
end
