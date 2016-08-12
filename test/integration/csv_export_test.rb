require 'test_helper'

class CsvExportTest < ActionDispatch::IntegrationTest
  # Make available sign_in and sign_out methods.
  # https://github.com/plataformatec/devise#integration-tests
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @moving = @user.movings.create(attributes_for(:moving))
    3.times { @moving.household_items.create(attributes_for(:household_item)) }
    sign_in @user
  end

  teardown do
    Rails.cache.clear
  end

  test "Exporting household_items csv" do
    get moving_household_items_url(@moving) + '.csv'
    assert_equal "application/csv", response.content_type

    # > response.body
    # => "name,volume,quantity,volume_subtotal,description\nChair 39,30,1,30,Very comfortable\nChair 38,30,1,30,Very comfortable\nChair 37,30,1,30,Very comfortable\n"
    attrs = %w[name volume quantity volume_subtotal description]
    first_item = @moving.household_items.first

    attrs.each do |attr|
      # Check field names in CSV.
      assert response.body.include? attr
      
      # Check data of the first item in CSV.
      assert response.body.include? first_item[attr].to_s
    end

    # Check if the CSV has correct number of rows.
    num_of_rows = 1 + @moving.household_items.count
    assert_equal num_of_rows, response.body.split(/\n/).size
  end
end
