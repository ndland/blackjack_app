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

class Table < ActiveRecord::Base
  attr_accessible :max, :min, :name
  
end
