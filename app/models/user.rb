class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # ,,
  # :lockable, :timeoutable and :omniauthable
	acts_as_followable
  
	attr_accessible :email, :password, :password_confirmation, :remember_me,
	:password , :name, :mobile, :location, :bio, :gender, :city, :country,
  :website, :photo
	
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  :trackable, :validatable, :confirmable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  validates :name, :mobile, :location, :bio, :gender, :city, :country, 
  :website, :presence => true
  
  validates :name, :uniqueness =>true

	has_many :tweets, :order => "created_at DESC"
  
  has_attached_file :photo, :styles => { :medium => "100x100>", :thumb => "38x38>" }

end
