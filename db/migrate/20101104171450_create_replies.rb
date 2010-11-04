class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.integer :content_id
      t.integer :discussion_id
      t.integer :commentor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :replies
  end
end
