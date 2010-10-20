class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :identification_code
      t.string :site_name
      t.string :site_type
      t.string :site_assoc_rating

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
