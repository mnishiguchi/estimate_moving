# == Schema Information
#
# Table name: household_items
#
#  id          :integer          not null, primary key
#  name        :string
#  volume      :integer
#  quantity    :integer
#  description :text
#  moving_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe HouseholdItem, type: :model do
  let(:household_item) { FactoryGirl.create(:household_item) }

  it { expect(household_item).to be_valid }
  
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :volume }
  it { is_expected.to validate_numericality_of :volume }
  it { is_expected.to validate_presence_of :quantity }
  it { is_expected.to validate_numericality_of :quantity }
  it { is_expected.to_not validate_presence_of :description }
end
