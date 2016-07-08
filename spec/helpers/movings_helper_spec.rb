require 'rails_helper'

RSpec.describe MovingsHelper, type: :helper do

  describe "m3_to_ft3" do
    it "returns a correct value" do
      volume_m3 = 5.5
      expect(m3_to_ft3(volume_m3)).to be_within(0.01).of(194.23)
    end
  end

  describe "ft3_to_m3" do
    it "returns a correct value" do
      volume_ft3 = 12
      expect(ft3_to_m3(volume_ft3)).to be_within(0.01).of(0.34)
    end
  end
end
