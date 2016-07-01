class CreateMovings < ActiveRecord::Migration[5.0]
  def change
    create_table :movings do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
