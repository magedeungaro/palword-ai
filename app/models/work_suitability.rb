# == Schema Information
#
# Table name: work_suitabilities
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class WorkSuitability < ApplicationRecord
  has_many :pal_work_suitabilities
  has_many :pals, through: :pal_work_suitabilities
end
