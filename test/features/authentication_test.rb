require "test_helper"

class AuthenticationTest < Capybara::Rails::TestCase
  # Make available sign_in and sign_out methods.
  # https://github.com/plataformatec/devise#integration-tests
  include Devise::Test::IntegrationHelpers

  scenario "non-logged-in user need to log in before creating a moving" do

    # Try to access the new moving page.
    user = create(:user)
    visit new_moving_path

    # Require user to log in.
    within "#new_user" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "password"
    end

    click_button "Log in"

    # Fill out the new moving form.
    within "#new_moving" do
      fill_in "Name", with: "Moving to Nagoya"
    end

    click_link_or_button "Create"

    # Moving is saved.
    assert { "Moving to Nagoya" == Moving.last.name }
  end

  scenario "logged in user can create a new moving" do

    sign_in create(:user)
    visit new_moving_path
    # puts page.body

    within "#new_moving" do
      fill_in "Name", with: "Moving to downtown"
    end

    click_link_or_button "Create moving"

    # Moving is saved.
    assert { "Moving to downtown" == Moving.last.name }
  end
end
