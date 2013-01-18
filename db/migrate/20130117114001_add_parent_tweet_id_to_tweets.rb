class AddParentTweetIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :parent_tweet_id, :integer, :default => 0
  end
end
