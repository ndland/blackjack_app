# == Schema Information
#
# Table name: game_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  table      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GameList < ActiveRecord::Base
	attr_accessible :table, :user_id

	validates :table, :uniqueness => { :scope => :user_id }
end
