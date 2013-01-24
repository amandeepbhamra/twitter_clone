class Renameuserscolumns < ActiveRecord::Migration
  def self.up
  	rename_column :tweets, :reply, :reply_tweet_id
  	rename_column :tweets, :status, :content
  end 
  
  def self.down
  	rename_column :tweets, :reply_tweet_id, :reply
  	rename_column :tweets, :content, :status
  end
end
