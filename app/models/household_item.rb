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
  validates :volume, presence: true
  validates :quantity, presence: true
  validates :description, length: { maximum: 255 }

  default_scope -> { order(:updated_at).reverse_order }

  # Used when an item is created or edited.
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      # If the tag does not already exist, create it.
      Tag.where(name: name.strip).first_or_create!
    end
  end

  # All the tags separated by commas.
  # Used for showing currently-set tags in a form.
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  # Array of all the tag names.
  # Used for displaying tags in a view.
  def tag_names
    self.tags.map(&:name)
  end

  # Takes the name of the specified tag and search for items associated with it.
  def self.tagged_with(name)
    Tag.find_by_name!(name).household_items
  end
end
