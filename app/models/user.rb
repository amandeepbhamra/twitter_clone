class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # ,,
  # :lockable, :timeoutable and :omniauthable
	acts_as_followable
  

	attr_accessible :email, :password, :password_confirmation, :remember_me,
	:password , :name, :mobile, :location, :bio, :gender, :city, :country,
  :website
	
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  :trackable, :validatable, :confirmable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  validates :name, :mobile, :location, :bio, :gender, :city, :country, 
  :website, :presence => true
  
  validates :name, :uniqueness =>true

	has_many :tweets
  
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

end
