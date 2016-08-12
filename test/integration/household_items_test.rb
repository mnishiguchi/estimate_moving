require 'test_helper'

class HouseholdItemsTest < ActionDispatch::IntegrationTest
  # Make available sign_in and sign_out methods.
  # https://github.com/plataformatec/devise#integration-tests
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @moving = @user.movings.create(attributes_for(:moving))
    3.times { @moving.household_items.create(attributes_for(:household_item)) }
  end

  teardown do
    Rails.cache.clear
  end

  test "index page" do
    sign_in @user
    get moving_household_items_url(@moving)
    assert_select 'title', full_title(@moving.name)
    assert_template 'household_items/index'
    assert_select 'a[href=?]', new_moving_household_item_path(@moving)

    first_item = @moving.household_items.first
    assert_select 'a[href=?]', edit_moving_path(@moving)
    assert_select 'a[href=?]', new_moving_household_item_path(@moving)
    assert_select "tbody tr", count: @moving.household_items.count
    assert_select "#household_item-#{first_item.id} td", first_item.name

    assert_select '#moving_volume_chart'
    assert_select '.moving_stats', /Total/
    assert_select '.moving_stats', /\d+.*(ft3|m3)/
    assert_select '.moving_stats', /\d+.*pcs/
  end

  test "new page" do
    sign_in @user
    first_item = @moving.household_items.first
    get new_moving_household_item_url(@moving)
    assert_template 'household_items/new'
    assert_select 'title', full_title("New household item")
    assert_select 'a[href=?]', moving_household_items_path(@moving)

    assert_select '#moving_volume_chart'
  end

  test "edit page" do
    sign_in @user
    first_item = @moving.household_items.first
    get edit_moving_household_item_url(@moving, first_item)
    assert_template 'household_items/edit'
    assert_select 'title', full_title("Edit household item")
  end
end
