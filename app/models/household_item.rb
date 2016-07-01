# == Schema Information
#
# Table name: household_items
#
#  id          :integer          not null, primary key
#  name        :string
#  volume      :integer
#  quantity    :integer
#  description :text
#  moving_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HouseholdItem < ApplicationRecord
  belongs_to :moving
  
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
end
