class CreateDefaultVolumes < ActiveRecord::Migration[5.0]
  def change
    create_table :default_volumes do |t|
      t.string :name
      t.float :volume

      t.timestamps
    end
  end
end
