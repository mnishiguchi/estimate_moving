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
#  unit        :integer          default("us")
#

require 'test_helper'

class MovingTest < ActiveSupport::TestCase

  def setup
    @moving = create(:moving)
  end

  test "should be valid" do
    assert @moving.valid?
  end

  test "name should be present" do
    @moving.name = "   "
    assert_not @moving.valid?
  end

  test "description should not be too long" do
    @moving.description = 'a' * 256
    assert_not @moving.valid?
  end

  test "unit should be present" do
    @moving.unit = nil
    assert_not @moving.valid?
  end
end
