class CardController < ApplicationController

  def create_sleeve
    Card.destroy_all

    ["D", "S", "H", "C"].each do |suit|
      ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].each do |fv|
        6.times{
          Card.create(faceValue: fv, suit: suit)
        }
      end
    end

    shuffle

  end

  def shuffle
    order = *(1..312)
    order.shuffle!
    Card.find_each do |card|
     card.cardUsed = false
     card.order = order.pop
    card.save
    end
  end
  # def get_card
  #   card = Sleeve.find(:first, conditions: {cardUsed: false})
  #   if card == nil
  #     create_sleeve
  #     get_card
  #   else
  #     card.cardUsed = true
  #     card.save
  #     return card
  #   end
  # end
end
