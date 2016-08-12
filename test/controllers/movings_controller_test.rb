require 'test_helper'

class MovingsControllerTest < ActionDispatch::IntegrationTest
  # Make available sign_in and sign_out methods.
  # https://github.com/plataformatec/devise#integration-tests
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @moving = @user.movings.create(attributes_for(:moving))
  end

  # NOTE: Only logged-in user can access Moving therefore in this test
  # all attempts result in redirects to the user sign up page.


  #---
  # Non-logged-in user
  #---


  test "GET #index" do
    get movings_url
    assert_redirected_to "/users/sign_in"
  end

  test "GET #new" do
    get new_moving_url
    assert_redirected_to "/users/sign_in"
  end

  test "POST #create" do
    assert_no_difference('Moving.count') do
      post movings_url, params: attributes_for(:moving)
    end

    assert_redirected_to "/users/sign_in"
  end

  test "GET #edit" do
    get edit_moving_url(@moving)
    assert_redirected_to "/users/sign_in"
  end

  test "PATCH #update" do
    patch moving_url(@moving), params: attributes_for(:moving)
    assert_redirected_to "/users/sign_in"
  end

  test "DELETE #destroy" do
    assert_no_difference('Moving.count') do
      delete moving_url(@moving)
    end

    assert_redirected_to "/users/sign_in"
  end


  #---
  # Logged-in user
  #---


  test "GET #index when logged-in" do
    sign_in @user
    get movings_url
    assert_template 'movings/index'
  end

  test "GET #new when logged-in" do
    sign_in @user
    get new_moving_url
    assert_template 'movings/new'
  end

  test "POST #create when logged-in" do
    sign_in @user
    assert_difference('Moving.count', 1) do
      post movings_url,
        params: {
          moving: {
            name:        "Hikkoshi",
            description: "Eetokotoni hikkoshi suru"
          }
        }
    end

    assert_redirected_to moving_url(@user.movings.last)
  end

  test "GET #edit when logged-in" do
    sign_in @user
    get edit_moving_url(@moving)
    assert_template 'movings/edit'
  end

  test "PATCH #update when logged-in" do
    sign_in @user
    patch moving_url(@moving),
      params: {
        moving: {
          name:        "New name",
          description: "New description"
        }
      }

    assert_equal "New name", @moving.reload.name
    assert_equal "New description", @moving.reload.description

    assert_redirected_to moving_url(@moving)
  end

  test "DELETE #destroy when logged-in" do
    sign_in @user
    assert_difference('Moving.count', -1) do
      delete moving_url(@moving)
    end

    assert_redirected_to movings_url
  end
end
