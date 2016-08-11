require 'test_helper'

class MovingsHelperTest < ActiveSupport::TestCase

  test "::m3_to_ft3" do
    assert_in_delta 194.23, m3_to_ft3(5.5), 0.01
  end

  test "::ft3_to_m3" do
    assert_in_delta 0.34, ft3_to_m3(12), 0.01
  end
end
