class Addconfirmable < ActiveRecord::Migration
  def up
	change_table(:users) do |t| 
    t.confirmable 
  end 

  end

  def down
  end
end
