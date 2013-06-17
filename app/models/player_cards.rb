class PlayerCards < ActiveRecord::Base
  attr_accessible :faceValue, :suit, :game_id
end
