class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    # We do not need index for username because we do not use it for frequent search.
    # add_index :users, :username, unique: true
  end
end
