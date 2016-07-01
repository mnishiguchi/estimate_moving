# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { FactoryGirl.create(:tag) }

  it { expect(tag).to be_valid }
  it { is_expected.to validate_presence_of :name }
end
