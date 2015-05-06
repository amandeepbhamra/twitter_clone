class AddNameToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :name, :string
  	add_column :users, :mobile, :integer 
  	add_column :users, :location, :string
  	add_column :users, :bio, :text
  end
  def self.down
  	remove_column :users, :name
	remove_column :users, :mobile
	remove_column :users, :location
	remove_column :users, :bio
	end
end
