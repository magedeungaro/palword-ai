# == Schema Information
#
# Table name: elements
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Element < ApplicationRecord
  has_many :pal_elements
  has_many :pals, through: :pal_elements
end
