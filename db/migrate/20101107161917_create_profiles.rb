class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :profiletype
      t.integer :creator_id
      t.datetime :creationdate
      t.integer :latest_version_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
