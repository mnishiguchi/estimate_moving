require 'rails_helper'

shared_context "User logs into dashboard" do
  let!(:user) { create(:user) }
  let!(:moving) do
    # Create five items on the user's first moving.
    moving = user.movings.create(attributes_for(:moving))
    3.times do
      moving.household_items.create(attributes_for(:household_item))
    end

    # Add tags on some items.
    moving.household_items.sample.tags.create! name: "ruby"
    moving.household_items.sample.tags.create! name: "rails"

    moving
  end

  before(:each) do
    # Log in and visit the root path.
    login_as user, scope: :user
    visit root_path
  end
end
