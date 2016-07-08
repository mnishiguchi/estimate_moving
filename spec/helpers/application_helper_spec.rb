require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  
  describe "full_title" do
    it "includes the page title" do
      expect(full_title("About")).to match /\AAbout/
    end

    it "includes the base title" do
      expect(full_title("About")).to match(/Estimate moving\z/)
    end

    it "does not include a separator for the home page" do
      expect(full_title("")).not_to match(/\|/)
    end
  end
end
