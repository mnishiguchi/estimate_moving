require 'rails_helper'

RSpec.feature "Home page", type: :feature do

  # Create a user.
  let!(:user) { FactoryGirl.create(:user) }

  context "before logging in" do
    # Visit the home page without logging in.
    before { visit root_path }

    subject { page }

    it { is_expected.to have_title(full_title("")) }
    it { is_expected.to have_content("Please sign up or log in") }
    it { is_expected.to have_link("Home", href: root_path) }
    it { is_expected.to have_link("About", href: about_path) }
    it { is_expected.to have_link("Sign up", href: new_user_registration_path) }
    it { is_expected.to have_link("Log in", href: new_user_session_path) }
    it { is_expected.to have_selector('footer') }
  end

  context "after logging in" do
    before do
      # Create three movings on the user.
      3.times do
        user.movings.create(FactoryGirl.attributes_for(:moving))
      end

      # Log in and visit the root path.
      log_in_as user
      visit root_path
    end

    subject { page }

    it { is_expected.to have_title(full_title("All movings")) }
    it { is_expected.to have_content("All movings") }
    it { is_expected.to have_link("Account", href: "/users/edit") }
    it { is_expected.to have_link("Log out", href: "/users/sign_out") }
    it { is_expected.to have_content(user.email) }
    it { is_expected.to have_content(user.movings.first.name) }
    it { is_expected.to have_selector('.moving', count: 3 ) }

    it "has a list of household items" do
      within(".moving:first-child") do
        first_moving = user.movings.first
        is_expected.to have_link(first_moving.name, moving_household_items_path(first_moving))
        is_expected.to have_content(first_moving.name)
        is_expected.to have_content(first_moving.description)
        is_expected.to have_selector("a[href*='edit']", count: 1)
        is_expected.to have_selector("a[data-method=delete]", count: 1)
      end
    end
  end
end
