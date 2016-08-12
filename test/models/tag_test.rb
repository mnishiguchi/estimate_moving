# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase

  def setup
    @tag = create(:tag)
  end

  test "should be valid" do
    assert @tag.valid?
  end
end
