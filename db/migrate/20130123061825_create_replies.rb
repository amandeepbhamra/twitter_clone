class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :content, :limit=>128

      t.timestamps
    end
  end
end
