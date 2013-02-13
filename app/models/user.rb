class User < ActiveRecord::Base
  
	acts_as_followable

	attr_accessible :email, :password, :password_confirmation, :remember_me,
	:name, :mobile, :location, :bio, :gender, :city, :country,
  :website, :photo, :longitude, :latitude
	
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  :trackable, :validatable, :confirmable, :token_authenticatable

  validates :name, :mobile, :bio, :gender, :city, :country, 
  :website, :presence => true , :if => lambda{|a| !a.new_record?}
  validates :name, :uniqueness =>true , :if => lambda{|a| !a.new_record?}
  validates_numericality_of :mobile , :if => lambda{|a| !a.new_record?}
  validates_format_of :website, 
  :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
  :message => "It must be full like http://www.twitter.com",
  :if => lambda{|a| !a.new_record?}
  

	has_many :tweets, :order => "created_at DESC", :dependent => :destroy
  #accepts_nested_attributes_for :tweets, :reject_if => lambda { |a| a[:content].empty? }
  
  has_attached_file :photo, :styles => { :medium => "100x100>", :thumb => "38x38>" }, 
  :default_url => "/assets/users_sticker.png"

  geocoded_by :city
  after_validation :geocode

  define_index do
    indexes :name
  end

end