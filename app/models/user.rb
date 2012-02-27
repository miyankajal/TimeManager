class User < ActiveRecord::Base
	validate :id, :presence => true
	validate :name, :presence => true,
		:length => { :maximum => 128 }
	validate :email, :presence => true,
		:length => { :maximum => 128 }
	validate :phone,
		:length => { :maximum => 15 }
		
	has_and_belongs_to_many :tasks
	
end
