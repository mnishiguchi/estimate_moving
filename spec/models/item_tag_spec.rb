# == Schema Information
#
# Table name: item_tags
#
#  id                :integer          not null, primary key
#  household_item_id :integer
#  tag_id            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe ItemTag, type: :model do
  let(:item_tag) { FactoryGirl.create(:item_tag) }

  it { expect(item_tag).to be_valid }
end
