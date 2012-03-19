class CreateUserTasks < ActiveRecord::Migration
  def up
    create_table :user_tasks do |t|
      t.references :tasks
      t.references :users

      t.timestamps
    end
  end
  
 def down
	drop_table :user_tasks
  end
end
