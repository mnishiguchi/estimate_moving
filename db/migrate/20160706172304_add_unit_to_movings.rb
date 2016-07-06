class AddUnitToMovings < ActiveRecord::Migration[5.0]
  def change
    add_column :movings, :unit, :integer, default: 0
  end
end
