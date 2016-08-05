require 'rails_helper'

RSpec.describe HouseholdItemsHelper, type: :helper do

  describe "item_volume_json(moving)" do
    let(:moving) { create(:moving) }
    let(:json) do
      # NOTE: Seed the database because the default_volumes table
      # would otherwise be empty.
      Rails.application.load_seed
      item_volume_json(moving)
    end

    it { expect(json).to have_json_path("tv") }

    context "unit: us" do
      before(:each) { moving.update!(unit: "us") }

      it { expect(parse_json(json)["tv"]).to eq(25.0) }
    end

    context "unit: metric" do
      before(:each) { moving.update!(unit: "metric") }

      it { expect(parse_json(json)["tv"]).to eq(0.71) }
    end
  end

  describe "json_for_bar_chart(moving)" do

    before(:all) do
      # Create a moving.
      @moving = create(:moving)
      # Add items to the moving.
      10.times do
        @moving.household_items.create!(attributes_for :household_item)
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
