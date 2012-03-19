class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
	validate :id, :presence => true
	validate :last_name, :presence => true,
		:length => { :maximum => 128 }
	validate :first_name, :presence => true,
		:length => { :maximum => 128 }
	validate :email, :presence => true,
		:length => { :maximum => 128 }
	validate :phone,
		:length => { :maximum => 15 }
	validates :password,  :presence     => true,
		:confirmation => true,
		:length       => { :within => 8..64 }
	
	has_many :user_tasks	
	has_many :tasks, :through => :user_tasks

	attr_accessor :password
	attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :terms_of_use, :phone
	attr_accessible :task_attributes
	accepts_nested_attributes_for :tasks  
  
	validates_acceptance_of :terms_of_use, :message => " must be accepted."
	validates_presence_of :first_name, :last_name
	validates_format_of :first_name, :with => /^[a-zA-Z]+$/i, :message => "Numbers are not allowed. Only (a-z,A-Z) are allowed."
	validates_format_of :last_name, :with => /^[a-zA-Z]+$/i, :message => "Numbers are not allowed. Only (a-z,A-Z) are allowed."
	validates_uniqueness_of :email

end
