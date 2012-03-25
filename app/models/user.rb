class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :user_tasks	
	has_many :tasks, :through => :user_tasks
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  # Setup accessible (or protected) attributes for your model
	validate :id, :presence => true
	validate :last_name, :presence => true,
		:length => { :maximum => 128 }
	validate :first_name, :presence => true,
		:length => { :maximum => 128 }
	validate :email, :presence => true,
		:format     => { :with => email_regex },
		:uniqueness => { :case_sensitive => false },
		:length => { :maximum => 128 }
	validate :phone,
		:length => { :maximum => 15 }
	validates :password,  :presence     => true,
		:confirmation => true,
		:length       => { :within => 8..64 }
	
	before_save :encrypt_password
	
	attr_accessor :password
	attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :terms_of_use, :phone
	attr_accessible :task_attributes
	accepts_nested_attributes_for :tasks  
  
	validates_acceptance_of :terms_of_use, :message => " must be accepted."
	validates_presence_of :first_name, :last_name
	validates_format_of :first_name, :with => /^[a-zA-Z]+$/i, :message => "Numbers are not allowed. Only (a-z,A-Z) are allowed."
	validates_format_of :last_name, :with => /^[a-zA-Z]+$/i, :message => "Numbers are not allowed. Only (a-z,A-Z) are allowed."
	validates_uniqueness_of :email

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	#was task created?
	def task_created?(task)
		self.tasks.include?(task)
	end
	
	def find_new_tasks
		Task.new_task(self)
	end
	
	def find_completed_tasks
		Task.completed_task(self)
	end
	
	def find_due_tasks
		Task.due_task(self)
	end
	
	def find_deleted_tasks
		Task.deleted_task(self)
	end
	
	def craete_task!(tasks)
		user_tasks.create!(:tasks_id => tasks.id)
	end
	
	def destroy_task!(tasks)
		user_tasks.find_by_tasks_id(tasks).destroy
	end
	
	class << self
    def authenticate(email, submitted_password)
      user = find_by_email(email)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
    
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
	
end
