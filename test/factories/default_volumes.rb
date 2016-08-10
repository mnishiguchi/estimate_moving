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

FactoryGirl.define do
  factory :default_volume do
    volume 1.5
    name "MyString"
  end
end
