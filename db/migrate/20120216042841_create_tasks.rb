class CreateTasks < ActiveRecord::Migration
  def up
	create_table :tasks do |t|
	  t.integer :id, :null => false
	  t.string :name, :limit => 512, :null => false
      t.string :description, :limit => 1064
	  t.date :due_date
      #t.integer :task_status_id
	
      t.timestamps
    end
  end

  def down
	drop_table :tasks
  end
end
