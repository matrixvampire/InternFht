class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :identificationcode
      t.string :sitename
      t.string :sitetype
      t.string :siteassoc_rating

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
