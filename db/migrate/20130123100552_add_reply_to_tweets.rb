class AddReplyToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :reply, :integer, :default => 0
  end
end
