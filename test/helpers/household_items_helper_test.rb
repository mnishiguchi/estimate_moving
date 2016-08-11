require 'test_helper'

class HouseholdItemsHelperTest < ActiveSupport::TestCase

  def setup
    Rails.application.load_seed
    @moving = create(:moving)
  end

  test "::item_volume_json should contain tv as a key" do
    json_data = item_volume_json(@moving)
    assert_match "tv", json_data
  end

  test "::item_volume_json should contain values in correct unit" do
    @moving.update!(unit: "us")
    json_data = item_volume_json(@moving)
    assert_equal 25.0, JSON.parse(json_data)["tv"]

    @moving.update!(unit: "metric")
    json_data = item_volume_json(@moving)
    assert_equal 0.71, JSON.parse(json_data)["tv"]
  end

  test "::json_for_bar_chart should contain appropriate data" do
    # Add items to the moving.
    10.times do
      @moving.household_items.create!(attributes_for :household_item)
    end
    # Add a 'kichen' tag to each item.
    @moving.household_items.each { |item| item.all_tags = "kitchen" }

    # Invoke the method to be tested. It returns data in JSON format.
    data = json_for_bar_chart(@moving)

    # Convert data to Ruby hash to inspect the content of the data.
    data = JSON.parse(data)
    
    assert_not_nil data["names"]
    assert_not_nil data["values"]
    assert data["names"].is_a? Array
    assert data["values"].is_a? Array
    assert data["names"].any? { |name| name = 'kitchen' }
  end
end
