class CreateSitesAssociations < ActiveRecord::Migration
  def self.up
    create_table :sites_associations do |t|
      t.integer :people_id
      t.integer :site_id
      t.string :position

      t.timestamps
    end
  end

  def self.down
    drop_table :sites_associations
  end
end
