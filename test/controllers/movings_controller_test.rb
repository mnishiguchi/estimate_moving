require 'test_helper'

class MovingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    user = create(:user)
    @moving = user.movings.create(attributes_for(:moving))
  end

  # NOTE: Only logged-in user can access Moving therefore in this test
  # all attempts result in redirects to the user sign up page.

  test "GET /movings" do
    get movings_url
    assert_redirected_to "/users/sign_in"
  end

  test "GET /movings/new" do
    get new_moving_url
    assert_redirected_to "/users/sign_in"
  end

  test "POST /movings/:id" do
    assert_no_difference('Moving.count') do
      post movings_url,
        params: {
          moving: {
            name:        "Hikkoshi",
            description: "Eetokotoni hikkoshi suru"
          }
        }
    end

    assert_redirected_to "/users/sign_in"
  end

  test "GET /movings/:id/edit" do
    get edit_moving_url(@moving)
    assert_redirected_to "/users/sign_in"
  end

  test "PATCH /movings/:id" do
    patch moving_url(@moving),
      params: {
        moving: {
          name:   "New name",
          description: "I am moving to that place"
        }
      }

    assert_redirected_to "/users/sign_in"
  end

  test "DELETE /movings/:id" do
    assert_no_difference('Moving.count') do
      delete moving_url(@moving)
    end

    assert_redirected_to "/users/sign_in"
  end
end
