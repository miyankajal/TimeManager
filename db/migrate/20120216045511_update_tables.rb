class UpdateTables < ActiveRecord::Migration
  def up
  
	execute <<-SQL
      ALTER TABLE tasks  
		ADD CONSTRAINT FK_status_id
		FOREIGN KEY (task_status_id) REFERENCES task_statuses(id)
		ON UPDATE CASCADE  
		ON DELETE CASCADE
    SQL
	
	execute <<-SQL
      ALTER TABLE user_tasks  
		ADD CONSTRAINT FK_task_id
		FOREIGN KEY (task_id) REFERENCES tasks(id)
		ON UPDATE CASCADE  
		ON DELETE CASCADE
    SQL

	execute <<-SQL
      ALTER TABLE user_tasks  
		ADD CONSTRAINT FK_user_id
		FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE  
		ON DELETE CASCADE
    SQL

  end

  def down
  end
end
