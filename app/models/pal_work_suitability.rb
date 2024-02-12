# == Schema Information
#
# Table name: pal_work_suitabilities
#
#  id                  :bigint           not null, primary key
#  level               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  pal_id              :bigint           not null
#  work_suitability_id :bigint           not null
#
# Indexes
#
#  index_pal_work_suitabilities_on_pal_id               (pal_id)
#  index_pal_work_suitabilities_on_work_suitability_id  (work_suitability_id)
#
# Foreign Keys
#
#  fk_rails_...  (pal_id => pals.id)
#  fk_rails_...  (work_suitability_id => work_suitabilities.id)
#
class PalWorkSuitability < ApplicationRecord
  belongs_to :pal
  belongs_to :work_suitability
end
