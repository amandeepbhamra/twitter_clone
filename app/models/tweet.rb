class Tweet < ActiveRecord::Base
 	belongs_to :user
 	attr_accessible :status, :user_id
 	validate :status, :presence=>true
end
