# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  suit       :string(255)
#  faceValue  :string(255)
#  cardUsed   :boolean
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:card) do
  suit      "MyString"
  faceValue "MyString"
  cardUsed  false
  order     1
end
