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
    @cards  = DealerCards.find(:all, conditions:{game_id: game_id})

    if faceValue_total(@cards) < 17
      deal_dealer_card(game_id)
      play(game_id)
    end
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

  def find_winner(game_id)
    @player_cards = PlayerCards.find(:all, conditions:{game_id: game_id})
    @dealer_cards = DealerCards.find(:all, conditions:{game_id: game_id})

    @player_cards_total = over21?(faceValue_total(@player_cards))
    @dealer_cards_total = over21?(faceValue_total(@dealer_cards))

    if @player_cards_total > @dealer_cards_total
      return "Player"
    elsif @player_cards_total == @dealer_cards_total
      return "No Winner: game was a push"
    else
      return "Dealer"
    end
  end

  def over21? (cardTotal)
    if cardTotal > 21
      cardTotal = 0
    end
    return cardTotal
  end
end
