require 'rails_helper'

RSpec.describe MovingsHelper, type: :helper do

  describe "m3_to_ft3" do
    subject { m3_to_ft3(5.5) }
    
    it { is_expected.to be_within(0.01).of(194.23) }
  end

  describe "ft3_to_m3" do
    subject { ft3_to_m3(12) }

    it { is_expected.to be_within(0.01).of(0.34) }
  end
end
