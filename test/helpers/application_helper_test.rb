require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase

  test "full_title should include the page title" do
    assert_match /\AAbout/, full_title("About")
  end

  test "full_title should include the base title" do
    assert_match /Estimate moving\z/, full_title("About")
  end

  test "full_title should not include a separator for the home page" do
    assert_equal "Estimate moving", full_title("")
  end
end
