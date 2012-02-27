class CreateUser < ActiveRecord::Migration
  def up
	create_table :users do |t|
	  t.integer :id, :null => false
      t.string :name, :limit => 128, :null => false
      t.string :phone, :limit => 15
      t.string :email, :limit => 128, :null => false
	  
	  t.timestamps
	  end
  end

  def down
	drop_table :users
  end
end
