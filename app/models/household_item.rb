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

class HouseholdItem < ApplicationRecord
  belongs_to :moving

  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  validates :name, presence: true
  validates :volume, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, length: { maximum: 255 }

  before_save :downcase_name  # Standardizes on all lower-case words.
  before_save :calculate_volume_using_correct_unit

  default_scope -> { order(:updated_at).reverse_order }

  # Search for items by the specified tag name.
  # Require moving id to enforce privacy.
  def self.tagged_with(name, moving_id)
    if name.present? && moving_id
      Tag.find_by_name!(name).household_items.where(moving_id: moving_id)
    end
  end

  # The virtual attribute `tags`
  # - An array of strings
  # - Holds a collection of tags that are associated with a household item.

  # Used for processing user's input when an item is created or edited.
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      # If a tag does not already exist, create it.
      Tag.where(name: name.strip).first_or_create!
    end.uniq
  end

  # The string representation of all the tags that are associated with a household item.
  # Used for showing currently-set tags in a form.
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def volume_m3
    ft3_to_m3(self.volume)
  end

  def volume_ft3
    self.volume
  end

  def volume_in_correct_unit
    case self.moving.unit
    when "metric" then volume_m3
    when "us"     then volume_ft3
    else volume_ft3
    end
  end

  private

    def calculate_volume_using_correct_unit
      if self.moving.unit == "metric"
        self.volume = m3_to_ft3(self.volume)
      end
    end

    def downcase_name
      self.name.downcase!
    end
end
