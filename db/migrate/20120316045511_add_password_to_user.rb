class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :password, :string
  end

  def down
	remove_column :users, :password, :string
  end
end
