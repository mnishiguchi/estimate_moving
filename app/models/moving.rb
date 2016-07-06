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

class Moving < ApplicationRecord
  belongs_to :user
  has_many   :household_items, dependent: :destroy

  enum unit: { us: 0, metric: 1 }

  validates :name, presence: true
  validates :description, length: { maximum: 255 }
  validates :unit, presence: true

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

  def volume_unit_string
    case self.unit
    when "us"     then "cft"
    when "metric" then "M3"
    end
  end

  def convert_volume_to_correct_unit(value)
    case self.unit
    when "metric" then ft3_to_m3(value)
    when "us"     then value
    else value
    end
  end
end
