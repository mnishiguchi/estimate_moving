require 'rails_helper'

RSpec.describe HouseholdItemsHelper, type: :helper do
  let!(:json_data) { File.read("#{Rails.root}/config/household_items.json") }

  describe "Load correct json data" do

    it "contains correct item names" do
      expect(json_data).to have_json_path("tv")
      expect(json_data).to have_json_path("armchair, large")
    end

    it "has an interger-type value for each key" do
      expect(json_data).to have_json_type(Integer).at_path("tv")
      expect(json_data).to have_json_type(Integer).at_path("armchair, large")
    end
  end

  describe "item_volume_json(moving)" do
    let!(:moving) { FactoryGirl.create(:moving) }

    subject { item_volume_json(moving) }

    context "unit: us" do
      before(:each) { moving.update!(unit: "us") }

      it "returns json with ft3 values" do
        expect(parse_json(subject)["tv"]).to eq(25)
      end
    end

    context "unit: metric" do
      before(:each) { moving.update!(unit: "metric") }

      it "returns json with m3 values" do
        expect(parse_json(subject)["tv"]).to eq(0.71)
      end
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

    it "contains correct keys (names & values)" do
      expect(subject).to have_json_path("names")
      expect(subject).to have_json_path("values")
    end

    it "has an array for each key" do
      expect(subject).to have_json_type(Array).at_path("names")
      expect(subject).to have_json_type(Array).at_path("values")
    end
  end
end
