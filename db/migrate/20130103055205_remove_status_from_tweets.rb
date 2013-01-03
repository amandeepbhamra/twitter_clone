class RemoveStatusFromTweets < ActiveRecord::Migration
  def up
    add_column :tweets, :status, :text, :limit => 140
    
  end

  def down
    remove_column :tweets, :status
  end
end
