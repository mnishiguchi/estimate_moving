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
#  unit        :integer          default(0)
#

FactoryGirl.define do
  factory :moving do
    name "My moving to a nice apartment"
    description "Location is DC"
    user
  end
end
