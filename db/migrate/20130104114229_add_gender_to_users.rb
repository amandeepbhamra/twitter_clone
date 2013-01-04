class AddGenderToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :website, :string
  end
  def self.down
    add_column :users, :gender
    add_column :users, :city
    add_column :users, :country
    add_column :users, :website
  end
end
