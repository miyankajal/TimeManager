class Task < ActiveRecord::Base
	validate :id, :presence => true
	validate :name, :presence => true,
		:length => { :maximum => 512 }
	validate :description,
		:length => { :maximum => 1064 }
		
	#has_one :task_status, :class_name => "TaskStatus", :conditions => {:primary => true}
	has_many :user_tasks
	has_many :users, :through => :user_tasks
	
	attr_accessible :name, :description, :status
	attr_accessible :user_attributes #, :task_status_attributes
	accepts_nested_attributes_for :users #, :task_statuses
	
	#scope :task_status, lambda { |status| {} }
	
	#validates_inclusion_of :status, :in => [:new, :completed, :due, :deleted]
	STATUS = %w[new completed due deleted]
	
	scope :new_tasks, lambda{ |user| do
		task = get_tasks_for_user(user)
		for task in @tasks
			task.where(':status => "new"')
		end
	end
	}
	
	scope :completed_tasks, lambda{ |user| do
		task = get_tasks_for_user(user)
		for task in @tasks
			task.where(':status => "completed"')
		end
	end
	}
	
	scope :due_tasks, lambda{ |user| do
		task = get_tasks_for_user(user)
		for task in @tasks
			task.where(':status => "due"')
		end
	end
	}
	
	scope :deleted_tasks, lambda{ |user| do
		task = get_tasks_for_user(user)
		for task in @tasks
			task.where(':status => "deleted"')
		end
	end
	}
	
	def status_symbols
		[status.to_sym]
	end
	
	def due_today()
		get_tasks_for_user(user)
	end
	  	
	private
	
		def self.get_tasks_for_user(user)
		
			tasks = Task.find(:all,:joins => "INNER JOIN user_tasks ON user_tasks.tasks_id = tasks.id INNER JOIN users ON user_tasks.users_id = users.id",/
				:select => 'tasks.name, tasks.description, tasks.status', :conditions => ['users.id = ?', user.id)
		end
	


end
