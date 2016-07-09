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

require 'rails_helper'

RSpec.describe SocialProfile, type: :model do
  let(:moving) { FactoryGirl.create(:social_profile) }

  it { expect(moving).to be_valid }
end
