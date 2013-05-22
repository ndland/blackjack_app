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

Fabricator(:game_list) do
  user_id 1
  table_id 1
end
