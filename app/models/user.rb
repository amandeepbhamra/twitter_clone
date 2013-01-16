class User < ActiveRecord::Base
  
	acts_as_followable

	attr_accessible :email, :password, :password_confirmation, :remember_me,
	:password , :name, :mobile, :location, :bio, :gender, :city, :country,
  :website, :photo, :longitude, :latitude
	
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  :trackable, :validatable, :confirmable,:token_authenticatable

  # validates :name, :mobile, :location, :bio, :gender, :city, :country, 
  # :website, :presence => true
  # validates :name, :uniqueness =>true
  # validates_numericality_of :mobile
  # validates_format_of :website, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

	has_many :tweets, :order => "created_at DESC"
  
  has_attached_file :photo, :styles => { :medium => "100x100>", :thumb => "38x38>" }

  geocoded_by :city
  after_validation :geocode

  define_index do
    indexes :name
  end

end