# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :item_tags, dependent: :destroy
  has_many :household_items, through: :item_tags

  validates :name, presence: true, uniqueness: true

  before_save :downcase_name  # Standardizes on all lower-case words.

  private

    def downcase_name
      self.name.downcase!
    end
end
