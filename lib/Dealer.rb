class Dealer

  attr_accessor :card

  def initialize
    @card = Card.new
  end

  def new_hand(game_id)
    [Winner, DealerCards, PlayerCards].each do |model|
      model.destroy_all(game_id: game_id)
    end

    2.times{
      deal_dealer_card(game_id)
      deal_player_card(game_id)
    }
  end

  def deal_player_card(game_id)
    @player_cards_hand  = find_cards(PlayerCards, game_id)
    if @player_cards_hand == [] || faceValue_total(@player_cards_hand) < 21
      newCard = card.get_card
      PlayerCards.create(suit: newCard.suit, faceValue: newCard.faceValue, game_id: game_id)
    else
      play(game_id)
    end
  end

  def deal_dealer_card(game_id)
    newCard = card.get_card
    DealerCards.create(suit: newCard.suit, faceValue: newCard.faceValue, game_id: game_id)
  end

  def play(game_id)
    @cards  = find_cards(DealerCards, game_id)

    if faceValue_total(@cards) < 17
      deal_dealer_card(game_id)
      play(game_id)
    else
      find_winner(game_id)
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
    @player_cards_total = checkOver21(faceValue_total(find_cards(PlayerCards, game_id)))
    @dealer_cards_total = checkOver21(faceValue_total(find_cards(DealerCards, game_id)))

    outcome = "Dealer is the Winner"

    if @player_cards_total > @dealer_cards_total
      pay_player(game_id, 2)
      outcome = "Player is the Winner"
    elsif @player_cards_total == @dealer_cards_total
      pay_player(game_id, 1)
      outcome = "No Winner: game was a push"
    end
    Winner.create(outcome: outcome, game_id: game_id)
  end

  def checkOver21(cardTotal)
    if cardTotal > 21
      cardTotal = 0
    end
    return cardTotal
  end

  def find_cards(model, game_id)
    return model.find(:all, conditions:{game_id: game_id})
  end

  def pay_player(game_id, payback_ratio)
    user = Person.first
    payout = GameList.find(:first, conditions: { id: game_id })
    winnings = payout.bet_amount * payback_ratio
    user.credits += winnings
    user.save
  end
end
