class AddNameToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :name, :string
  	add_column :users, :password, :string
  	add_column :users, :email, :string
	add_column :users, :mobile, :integerrake 
  	add_column :users, :location, :string
  	add_column :users, :bio, :text
  	add_column :users, :photo, :string
  	add_column :users, :headerphoto, :string
  end
  def self.down
  	remove_column :users, :name
	remove_column :users, :password
	remove_column :users, :email
	remove_column :users, :mobile
	remove_column :users, :location
	remove_column :users, :bio
	remove_column :users, :photo
	remove_column :users, :headerphoto
  end
end
