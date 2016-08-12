require 'test_helper'
require_relative '../support/omniauth_utils'

class OmniAuthCallbacksControllerTest < ActionDispatch::IntegrationTest
  # Make available sign_in and sign_out methods.
  # https://github.com/plataformatec/devise#integration-tests
  include Devise::Test::IntegrationHelpers

  OmniAuth.config.test_mode = true

  def setup
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  teardown do
    Rails.cache.clear
  end

  test "non-logged-in user who is not previously registered with Twitter should be asked for his/her email address after successful authentication" do
    set_omniauth
    get user_twitter_omniauth_authorize_url
    assert_redirected_to user_twitter_omniauth_callback_url
    follow_redirect!
    user = User.last
    assert_redirected_to finish_signup_url(user)
    follow_redirect!
    assert_select 'div', 'Please enter your email address before proceeding.'
    assert_select 'input[type=email]'
  end

  test "non-logged-in user registered with Twitter should be logged in after successful authentication" do
    user = create(:user)
    attrs = attributes_for(:social_profile)
    attrs["uid"] = "mock_uid_1234567890"
    user.social_profiles.create(attrs)

    set_omniauth
    get user_twitter_omniauth_authorize_url
    assert_redirected_to user_twitter_omniauth_callback_url
    follow_redirect!
    assert_redirected_to root_url
    follow_redirect!
    assert_redirected_to movings_url
    follow_redirect!
    assert_select 'div', /\ASuccessfully authenticated/
  end
end
