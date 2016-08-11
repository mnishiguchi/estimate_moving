require 'rails_helper'

shared_context "New user logs into dashboard" do
  let!(:user) { create(:user) }

  before(:each) do
    # Log in.
    visit new_user_session_path
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Log in"

    # Visit the root path.
    visit root_path
  end
end

shared_context "Returned user logs into dashboard" do
  let!(:user) { create(:user) }
  let!(:moving) do
    # Create three items on the user's first moving.
    moving = user.movings.create(attributes_for(:moving))
    3.times do
      moving.household_items.create(attributes_for(:household_item))
    end

    # Add tags on some household items.
    moving.household_items.sample.tags.create! name: "ruby"
    moving.household_items.sample.tags.create! name: "rails"

    moving
  end

  before(:each) do
    # Log in.
    visit new_user_session_path
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Log in"

    # Visit the root path.
    visit root_path
  end
end
