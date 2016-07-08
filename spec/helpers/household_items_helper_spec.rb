require 'rails_helper'

RSpec.describe HouseholdItemsHelper, type: :helper do
  
  # Load the data from a file.
  let!(:json_data) { File.read("#{Rails.root}/config/household_items.json") }

  describe "Load correct json data" do

    subject { json_data }

    it { is_expected.to have_json_path("tv") }
    it { is_expected.to have_json_path("armchair, large") }
    it { is_expected.to have_json_type(Integer).at_path("tv") }
    it { is_expected.to have_json_type(Integer).at_path("armchair, large") }
  end

  describe "item_volume_json(moving)" do
    let!(:moving) { FactoryGirl.create(:moving) }

    subject do
      result = item_volume_json(moving)
      parse_json(result)["tv"]
    end

    context "unit: us" do
      before(:each) { moving.update!(unit: "us") }

      it { is_expected.to eq(25) }
    end

    context "unit: metric" do
      before(:each) { moving.update!(unit: "metric") }

      it { is_expected.to eq(0.71) }
    end
  end

  describe "json_for_bar_chart(moving)" do

    before(:all) do
      # Create a moving.
      @moving = FactoryGirl.create(:moving)
      # Add items to the moving.
      10.times do
        @moving.household_items.create!(FactoryGirl.attributes_for :household_item)
      end
      # Add tags to each item.
      @moving.household_items.each { |item| item.tags.create name: "kitchen" }
    end

    subject { json_for_bar_chart(@moving) }

    # Contains correct keys (names & values)
    it { is_expected.to have_json_path("names") }
    it { is_expected.to have_json_path("values") }
    # Has an array for each key.
    it { is_expected.to have_json_type(Array).at_path("names") }
    it { is_expected.to have_json_type(Array).at_path("values") }
  end
end
