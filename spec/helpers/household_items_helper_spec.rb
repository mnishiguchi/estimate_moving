require 'rails_helper'

RSpec.describe HouseholdItemsHelper, type: :helper do

  # Load the data from a file.
  let!(:ft3_hash) { YAML.load_file("#{Rails.root}/config/household_items.yml") }

  describe "data hash" do
    it "is a hash of name-volume pairs" do
      expect(ft3_hash["tv"]).not_to eq nil
      expect(ft3_hash["tv"]).to be_a Fixnum
      expect(ft3_hash["curtain"]).not_to eq nil
      expect(ft3_hash["curtain"]).to be_a Fixnum
    end
  end

  describe "item_volume_json(moving)" do
    let(:moving) { FactoryGirl.create(:moving) }

    subject(:json) do
      item_volume_json(moving)
    end

    it { expect(subject).to have_json_path("tv") }

    context "unit: us" do
      before(:each) { moving.update!(unit: "us") }

      it { expect(parse_json(json)["tv"]).to eq(25) }
    end

    context "unit: metric" do
      before(:each) { moving.update!(unit: "metric") }

      it { expect(parse_json(json)["tv"]).to eq(0.71) }
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
