require 'test_helper'

class TagTest < ActiveSupport::TestCase

  def setup
    @tag = create(:tag)
  end

  test "should be valid" do
    assert @tag.valid?
  end
end
