class Task < ActiveRecord::Base
	validate :id, :presence => true
	validate :name, :presence => true,
		:length => { :maximum => 512 }
	validate :description,
		:length => { :maximum => 1064 }
		
	has_one :task_status, :class_name => "TaskStatus", :conditions => {:primary => true}
	has_and_belongs_to_many :users
end
