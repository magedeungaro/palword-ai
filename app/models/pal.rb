# frozen_string_literal: true

# == Schema Information
#
# Table name: pals
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Pal < ApplicationRecord
  has_many :pal_elements
  has_many :elements, through: :pal_elements
  has_many :pal_work_suitabilities
  has_many :work_suitabilities, through: :pal_work_suitabilities
end
