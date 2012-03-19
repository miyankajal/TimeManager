class UserTask < ActiveRecord::Base
	validate :id, :presence => true
	validate :tasks_id, :presence => true
	validate :users_id, :presence => true
		
	belongs_to :tasks
	belongs_to :users 
end
