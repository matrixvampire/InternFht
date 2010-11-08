class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :contenttype
      t.datetime :creationdate
      t.integer :latest_version_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
