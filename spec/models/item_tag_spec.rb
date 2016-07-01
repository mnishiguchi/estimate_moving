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
  pending "add some examples to (or delete) #{__FILE__}"
end
