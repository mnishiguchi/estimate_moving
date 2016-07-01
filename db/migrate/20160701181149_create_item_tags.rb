class CreateItemTags < ActiveRecord::Migration[5.0]
  def change
    create_table :item_tags do |t|
      t.references :household_item, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
