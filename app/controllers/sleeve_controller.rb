class SleeveController < ApplicationController

  def create_sleeve
    Sleeve.destroy_all

    ((make_full_deck * 6).flatten!).each do |card|
      Sleeve.create(suit: card[1] , faceValue: card[0], cardUsed: false)
    end
  end

  def get_card
    if Sleeve.count != 312
      create_sleeve
    end

    card = Sleeve[0]
    card.cardUsed = true
    card.save
    return card
  end

  private

  def suit_of_cards(suit)
    face_value_cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

    return face_value_cards.collect {|x| x + suit}
  end

  def make_full_deck()
    return ["D", "S", "H", "C"].collect do |suit|
      suit_of_cards(suit)
    end
  end
end
