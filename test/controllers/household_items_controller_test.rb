require 'test_helper'

class HouseholdItemsControllerTest < ActionDispatch::IntegrationTest
  # Make available sign_in and sign_out methods.
  # https://github.com/plataformatec/devise#integration-tests
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @moving = @user.movings.create(attributes_for(:moving))
    3.times { @moving.household_items.create(attributes_for(:household_item)) }
  end

  # NOTE: Only logged-in user can access HouseholdItems therefore in this test
  # all attempts result in redirects to the user sign up page.


  #---
  # Non-logged-in user
  #---


  test "GET #index" do
    get moving_household_items_url(@moving)
    assert_redirected_to "/users/sign_in"

    # CSV export
    get moving_household_items_url(@moving) + '.csv'
    assert_not_equal "application/csv", response.content_type
  end

  test "GET #new" do
    get new_moving_household_item_url(@moving)
    assert_redirected_to "/users/sign_in"
  end

  test "POST #create" do
    assert_no_difference('HouseholdItem.count') do
      post moving_household_items_url(@moving),
        params: attributes_for(:household_item)
    end

    assert_redirected_to "/users/sign_in"
  end

  test "GET #edit" do
    get edit_moving_household_item_url(@moving, @moving.household_items.first)
    assert_redirected_to "/users/sign_in"
  end

  test "PATCH #update" do
    patch moving_household_item_url(@moving, @moving.household_items.first),
      params: attributes_for(:household_item)

    assert_redirected_to "/users/sign_in"
  end

  test "DELETE #destroy" do
    assert_no_difference('HouseholdItem.count') do
      delete moving_household_item_url(@moving, @moving.household_items.first)
    end

    assert_redirected_to "/users/sign_in"
  end


  #---
  # Logged-in user
  #---


  test "GET #index when logged-in" do
    sign_in @user
    get moving_household_items_url(@moving)
    assert_template "household_items/index"

    # CSV export
    get moving_household_items_url(@moving) + '.csv'
    assert_equal "application/csv", response.content_type
  end

  test "GET #new when logged-in" do
    sign_in @user
    get new_moving_household_item_url(@moving)
    assert_template "household_items/new"
  end

  test "POST #create when logged-in" do
    sign_in @user
    assert_difference "HouseholdItem.count", 1 do
      post moving_household_items_url(@moving, household_item: attributes_for(:household_item))
    end

    assert_redirected_to new_moving_household_item_url
  end

  test "GET #edit when logged-in" do
    sign_in @user
    get edit_moving_household_item_url(@moving, @moving.household_items.first)
    assert_template 'household_items/edit'
  end

  test "PATCH #update when logged-in" do
    sign_in @user
    first_item = @moving.household_items.first
    patch moving_household_item_url(@moving, first_item,
      household_item: {
        name:        "New name",
        description: "New description"
      })

    assert_equal "New name", first_item.reload.name
    assert_equal "New description", first_item.reload.description

    assert_redirected_to moving_household_items_url(@moving)
  end

  test "DELETE #destroy when logged-in" do
    sign_in @user
    assert_difference('HouseholdItem.count', -1) do
      # NOTE: This is performed by Ajax.
      delete moving_household_item_url(@moving, @moving.household_items.first), xhr: true
    end
  end
end
