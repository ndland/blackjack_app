# == Schema Information
#
# Table name: game_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  table_id   :integer
#  bet_amount :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GameList < ActiveRecord::Base
  attr_accessible :bet_amount, :table_id, :user_id

  validates :table_id, uniqueness: { scope: :user_id }
end
