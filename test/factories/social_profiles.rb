# == Schema Information
#
# Table name: social_profiles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  provider    :string
#  uid         :string
#  name        :string
#  nickname    :string
#  email       :string
#  url         :string
#  image_url   :string
#  description :string
#  others      :text
#  credentials :text
#  raw_info    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :social_profile do
    provider    "twitter"
    sequence(:uid) { |n| "mock_uid_#{n}" }
    name        "Mock User"
    nickname    "mock_nickname"
    email       "mock_email@example.com"
    url         "http://mock_url.com"
    image_url   "http://mock_image_url.com"
    description "mock_description"
    others      "MyText"
    credentials "MyText"
    raw_info    "MyText"
    user
  end
end
