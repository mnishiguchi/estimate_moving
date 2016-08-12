require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # Make available sign_in and sign_out methods.
  # https://github.com/plataformatec/devise#integration-tests
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @moving = @user.movings.create(attributes_for(:moving))
    @admin = create(:admin)
  end

  teardown do
    Rails.cache.clear
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'

    # Non-logged-in user
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', '/users/sign_in'
    assert_select 'a[href=?]', '/users/sign_up'

    # Logged-in user
    get '/users/sign_up'
    assert_select 'title', full_title("Sign up")
    sign_in @user
    get root_path
    assert_redirected_to movings_url
    follow_redirect!
    assert_template 'movings/index'
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', '/users/sign_in', count: 0
    assert_select 'a[href=?]', '/users/sign_up', count: 0

    # Non-admin-user
    get '/admin/default_volumes'
    assert_redirected_to '/admins/sign_in'

    # Admin user
    sign_out @user
    sign_in @admin
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', '/users/sign_in', count: 0
    assert_select 'a[href=?]', '/users/sign_up', count: 0
    assert_select 'a[href=?]', default_volumes_path
    get default_volumes_path
    assert_template 'default_volumes/index'
  end

  test "home page for non-logged-in user" do
    get root_path
    assert_select 'title', "Estimate moving"
  end

  test "home page for logged-in user" do
    sign_in @user
    get root_path
    follow_redirect!
    assert_select 'title', full_title("My moving projects")
    assert_select '.gravatar'
    assert_select 'h1', /\d moving project[s]?/
    assert_select '.gravatar_link', "Logged in as #{@user.username}"
    assert_select '.moving'
    assert_select '.add_moving'
    assert_select 'h2', @moving.name
    assert_select 'a[href=?]', moving_household_items_path(@moving)
    assert_select 'p', @moving.description
    assert_select 'a[href*="edit"]'
  end

  test "home page for admin user" do
    sign_in @admin
    get root_path
    assert_select 'title', full_title("")
    assert_select '.gravatar'
    assert_select 'div', /Admin Home/
  end
end
