# == Schema Information
#
# Table name: default_volumes
#
#  id         :integer          not null, primary key
#  name       :string
#  volume     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DefaultVolumeTest < ActiveSupport::TestCase

  def setup
    @desk = create(:default_volume)
  end

  test "should be valid" do
    assert @desk.valid?
  end
end
