class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # ,,
  # :lockable, :timeoutable and :omniauthable
	acts_as_followable

	attr_accessible :email, :password, :password_confirmation, :remember_me,
	:followable_id, :followable_type, :follower_id, :follower_type
  	attr_accessible :username, :password
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  
  
	has_many :tweets
  	

end
