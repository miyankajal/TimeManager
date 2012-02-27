class TaskStatus < ActiveRecord::Base
	validate :id, :presence => true
	validate :status, :presence => true,
		:length => { :maximum => 64 }
		
	belongs_to :task
end
