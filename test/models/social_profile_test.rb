require 'test_helper'

class SocialProfileTest < ActiveSupport::TestCase

  def setup
    @social_profile = create(:social_profile)
  end

  test "should be valid" do
    assert @social_profile.valid?
  end
end
