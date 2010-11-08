class CreateContentVersions < ActiveRecord::Migration
  def self.up
    create_table :content_versions do |t|
      t.integer :content_id
      t.string :title
      t.text :digest
      t.text :body
      t.string :contentstatus
      t.datetime :versiondate
      t.datetime :contentstatusdate

      t.timestamps
    end
  end

  def self.down
    drop_table :content_versions
  end
end
