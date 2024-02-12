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
end
