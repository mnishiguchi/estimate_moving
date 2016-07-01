class CreateHouseholdItems < ActiveRecord::Migration[5.0]
  def change
    create_table :household_items do |t|
      t.string   :name
      t.integer  :volume
      t.integer  :quantity
      t.text     :description
      t.references :moving, foreign_key: true

      t.timestamps
    end
  end
end
