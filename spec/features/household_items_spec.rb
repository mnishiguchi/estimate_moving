require 'rails_helper'
require "features/shared/contexts"

RSpec.feature "Household items page", type: :feature do

  include_context "User logs into dashboard"

  before(:each) { click_link moving.name }

  describe "visiting a moving detail page" do
    subject { page }

    it { expect(page).to have_title(full_title(moving.name)) }

    scenario "shows moving details" do
      is_expected.to have_content(moving.name)
      is_expected.to have_content(moving.description)
      is_expected.to have_content(moving.volume_unit_string)
      is_expected.to have_link("settings", href: edit_moving_path(moving))
      is_expected.to have_link("Add new household item", href: new_moving_household_item_path(moving))
    end

    context "clicking the 'Settings' link" do
      before(:each) { click_link("settings") }

      it { is_expected.to have_title("Edit moving") }
    end

    context "clicking the 'Add item' link" do
      before(:each) { click_link("Add new household item") }

      it { is_expected.to have_title("New household item") }
    end
  end

  # ---
  # ---

  describe "chart" do
    subject { page }

    it { is_expected.to have_selector('#moving_volume_chart') }
  end

  # ---
  # ---

  describe "stats" do
    subject { page }

    it "shows data in correct format" do
      within(".moving_stats") do
        is_expected.to have_content(/Total/)
        is_expected.to have_content(moving.volume_unit_string)
        is_expected.to have_content(/\d+.*(ft3|m3)/)
        is_expected.to have_content(/\d+.*pcs/)
      end
    end
  end

  # ---
  # ---

  describe "filter forms component" do
    subject { page }

    it "has correct tags that are capitalized" do
      within(".household_item_filter") do
        is_expected.to have_content("All")
        is_expected.to have_content("Ruby")
        is_expected.to have_content("Rails")
        is_expected.not_to have_content("ruby")
        is_expected.not_to have_content("rails")
      end
    end
  end

  # ---
  # ---

  describe "table component" do
    subject { page }

    let(:item_count) { moving.household_items.count }

    it "has a correct number of records" do
      is_expected.to have_selector('table tbody tr', count: item_count)
    end
  end
end
