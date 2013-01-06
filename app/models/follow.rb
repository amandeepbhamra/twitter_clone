class Follow < ActiveRecord::Base
	
	attr_accessible :followable_id, :followable_type, :follower_id, :follower_type

end