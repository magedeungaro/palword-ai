# == Schema Information
#
# Table name: pals
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Pal < ApplicationRecord
end
