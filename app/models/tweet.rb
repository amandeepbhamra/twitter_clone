class Tweet < ActiveRecord::Base
 	
 	attr_accessible :status, :user_id

 	belongs_to :user
 	
 	validate :status, :presence=>true, :limit => 140

  define_index do
    indexes :status
  end
end
