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

require 'test_helper'

class SocialProfileTest < ActiveSupport::TestCase

  def setup
    @social_profile = create(:social_profile)
  end

  test "should be valid" do
    assert @social_profile.valid?
  end
end
