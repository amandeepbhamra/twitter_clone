class Tweet < ActiveRecord::Base
 	
 	attr_accessible :status, :user_id

 	validate :status, :presence=>true, :limit => 140

 	has_many :retweets, :class_name => "Tweet", :foreign_key => "parent_tweet_id"
 	belongs_to :user, :counter_cache => true
 	
 	define_index do
		indexes :status
	end
end