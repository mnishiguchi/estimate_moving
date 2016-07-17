require 'rails_helper'
require "features/shared/examples"

RSpec.feature "Home page", type: :feature do

  # Create a user.
  let!(:user) { FactoryGirl.create(:user) }

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
    before do
      # Create three movings on the user.
      3.times do
        user.movings.create(FactoryGirl.attributes_for(:moving))
      end

      # Log in and visit the root path.
      login_as user
      visit root_path
    end

    subject { page }

    scenario "shows movings/index page" do
      is_expected.to have_title(full_title("My moving projects"))
      is_expected.to have_selector('.gravatar')
      is_expected.to have_content(/\d moving[s]? projects/)
      is_expected.to have_content("Logged in as #{user.username}")
      is_expected.to have_selector('.moving', count: 3 )
    end

    it "has a list of household items" do
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
