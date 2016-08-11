# == Schema Information
#
# Table name: movings
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  unit        :integer          default("us")
#

FactoryGirl.define do
  factory :moving do
    sequence(:name) { |n| "My moving #{n}" }
    description "Location is DC"
    unit "us"
    user
  end
end
