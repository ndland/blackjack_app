# == Schema Information
#
# Table name: dealer_cards
#
#  id         :integer          not null, primary key
#  faceValue  :string(255)
#  suit       :string(255)
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DealerCards < ActiveRecord::Base
  attr_accessible :faceValue, :game_id, :suit
end
