# == Schema Information
#
# Table name: movings
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  unit        :integer          default(0)
#

require 'rails_helper'

RSpec.describe Moving, type: :model do
  let(:moving) { FactoryGirl.create(:moving) }

  it { expect(moving).to be_valid }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.not_to validate_presence_of :description }
  it { is_expected.to validate_length_of :description }

  it { is_expected.to validate_presence_of :unit }
end
