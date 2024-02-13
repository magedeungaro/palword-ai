# frozen_string_literal: true

# == Schema Information
#
# Table name: pal_elements
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  element_id :bigint           not null
#  pal_id     :bigint           not null
#
# Indexes
#
#  index_pal_elements_on_element_id  (element_id)
#  index_pal_elements_on_pal_id      (pal_id)
#
# Foreign Keys
#
#  fk_rails_...  (element_id => elements.id)
#  fk_rails_...  (pal_id => pals.id)
#
class PalElement < ApplicationRecord
  belongs_to :pal
  belongs_to :element
end
