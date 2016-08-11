require 'rails_helper'
require "features/shared/contexts"
require "features/shared/examples"

RSpec.feature "Home page", type: :feature do

  # Create a user.
  let!(:user) { create(:user) }

  context "non-logged-in user" do
    describe "visiting root page" do
      before { visit root_path }
      it_behaves_like "non-logged-in user"
    end

    describe "visiting movings page" do
      before { visit movings_path }
      it_behaves_like "non-logged-in user"
    end
  end

  context "when logged in" do
    include_context "Returned user logs into dashboard"

    subject { page }

    it "shows movings/index page" do
      is_expected.to have_title(full_title("My moving projects"))
      is_expected.to have_selector('.gravatar')
      is_expected.to have_content(/\d moving project[s]?/)
      is_expected.to have_content("Logged in as #{user.username}")
      is_expected.to have_selector('.moving')
    end

    it "has a list of movings" do
      within(".moving:first-child") do
        first_moving = user.movings.first
        is_expected.to have_link(first_moving.name, moving_household_items_path(first_moving))
        is_expected.to have_content(first_moving.name)
        is_expected.to have_content(first_moving.description)
        is_expected.to have_selector("a[href*='edit']", count: 1)
      end
    end
  end
end
