class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :status, :limit=>140

      t.timestamps
    end
  end
end
