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
#

class Moving < ApplicationRecord
  belongs_to :user
  has_many   :household_items, dependent: :destroy

  validates :name, presence: true
  validates :description, length: { maximum: 255 }

  # All the tags that are associated with a moving.
  def tags
    Tag.joins(household_items: :moving)
       .where(movings: {id: id})
       .select('DISTINCT tags.name')
       .order('tags.name')
  end

  def volume_by_tag(name)
    HouseholdItem.tagged_with(name, self.id).sum(:volume)
  end
end
