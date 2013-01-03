class RemoveStatusFromTweets < ActiveRecord::Migration
  def up
    remove_column :tweets, :status
  end

  def down
    add_column :tweets, :status, :text, :limit => 140
  end
end
