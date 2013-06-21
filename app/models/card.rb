class Card < ActiveRecord::Base
  attr_accessible :cardUsed, :faceValue, :order, :suit
end
