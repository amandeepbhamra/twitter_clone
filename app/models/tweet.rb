class Tweet < ActiveRecord::Base
 	
 	attr_accessible :status, :user_id, :reply

 	validate :status, :presence=>true, :limit => 140

 	has_many :retweets, :class_name => "Tweet", :foreign_key => "parent_tweet_id", :order => "created_at DESC"
 	has_many :replies, :class_name => "Tweet", :foreign_key => "reply_id"


 	belongs_to :reply_of, :class_name => "Tweet", :foreign_key => "reply_id"

 	belongs_to :user, :counter_cache => true
 	
 	define_index do
		indexes :status
	end
end