# == Schema Information
#
# Table name: winners
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  outcome    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Winner < ActiveRecord::Base
  attr_accessible :game_id, :outcome
end
