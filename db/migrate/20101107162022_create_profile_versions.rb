class CreateProfileVersions < ActiveRecord::Migration
  def self.up
    create_table :profile_versions do |t|
      t.integer :profile_id
      t.text :digest
      t.text :body
      t.datetime :versiondate
      t.integer :alteredby_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profile_versions
  end
end
