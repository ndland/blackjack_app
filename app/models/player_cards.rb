# == Schema Information
#
# Table name: player_cards
#
#  id         :integer          not null, primary key
#  suit       :string(255)
#  faceValue  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer
#

class PlayerCards < ActiveRecord::Base
  attr_accessible :faceValue, :suit, :game_id
end
