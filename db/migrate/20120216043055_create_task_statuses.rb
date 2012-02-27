class CreateTaskStatuses < ActiveRecord::Migration
  def up
	create_table :task_statuses do |t|
	  t.integer :id, :null => false
      t.string :status

      t.timestamps
    end
  end

  def down
	drop_table :task_statuses
  end
end
