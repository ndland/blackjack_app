# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  credits    :integer
#  level      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:person) do
  name    "Bob Smith"
  credits 100
  level   1
end
