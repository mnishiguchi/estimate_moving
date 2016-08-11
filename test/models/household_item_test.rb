require 'test_helper'

class HouseholdItemTest < ActiveSupport::TestCase

  def setup
    @household_item = create(:household_item)
  end

  test "should be valid" do
    assert @household_item.valid?
  end

  test "name should be present" do
    @household_item.name = "  "
    assert_not @household_item.valid?
  end

  test "volume should be present" do
    @household_item.volume = "  "
    assert_not @household_item.valid?
  end
end
