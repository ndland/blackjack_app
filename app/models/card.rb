class Card < ActiveRecord::Base
  attr_accessible :cardUsed, :faceValue, :order, :suit

  def create_sleeve
    Card.destroy_all

    ["D", "S", "H", "C"].each do |suit|
      ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].each do |fv|
        6.times{
          Card.create(faceValue: fv, suit: suit)
        }
      end
    end
  end

  def create_cards_if_needed
    if Card.count != 312
      create_sleeve
    end
  end

  def shuffle
    create_cards_if_needed

    order = *(1..312)
    order.shuffle!

    Card.find_each do |card|
      card.cardUsed = false
      card.order = order.pop
      card.save
    end
  end

  def get_card
    card = Card.order("cards.order").find(:first, conditions: {cardUsed: false})

    if card == nil
      shuffle
      get_card
    else
      card.cardUsed = true
      card.save
      return card
    end
  end
end
