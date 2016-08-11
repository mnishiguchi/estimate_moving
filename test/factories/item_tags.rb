# == Schema Information
#
# Table name: item_tags
#
#  id                :integer          not null, primary key
#  household_item_id :integer
#  tag_id            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :item_tag do
    household_item
    tag
  end
end
