# == Schema Information
#
# Table name: tables
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  min        :integer
#  max        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

 Fabricator(:table) do
  name "Test"
  max 100
  min  10
end
