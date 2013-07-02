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

Fabricator(:winner) do
  game_id 1
  outcome "MyString"
end
