# == Schema Information
#
# Table name: default_volumes
#
#  id         :integer          not null, primary key
#  name       :string
#  volume     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DefaultVolume < ApplicationRecord
  attribute :volume, :integer
end
