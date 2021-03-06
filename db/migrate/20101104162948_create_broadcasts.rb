class CreateBroadcasts < ActiveRecord::Migration
  def self.up
    create_table :broadcasts do |t|
      t.integer :content_id
      t.integer :administrator_id
      t.date :releasedate
      t.date :expirationdate

      t.timestamps
    end
  end

  def self.down
    drop_table :broadcasts
  end
end
