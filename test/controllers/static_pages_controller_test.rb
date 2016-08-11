require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "GET #home" do
    get root_url
    assert_response :success
  end

  test "GET #about" do
    get about_url
    assert_response :success
  end
end
