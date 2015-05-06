class RemoveLocationFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :location
  end

  def self.down
    add_column :users, :location, :string
  end
end
