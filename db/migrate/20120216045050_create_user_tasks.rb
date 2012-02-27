class CreateUserTasks < ActiveRecord::Migration
  def up
	create_table :user_tasks do |t|
	  t.integer :id, :null => false
      t.integer :user_id, :null => false
	  t.integer :task_id, :null => false

      t.timestamps
	end
  end

  def down
  end
end
