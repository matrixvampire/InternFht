class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :buildingnumber
      t.string :streetname
      t.string :areaname
      t.string :city
      t.string :zippostal_code
      t.string :state_province
      t.string :region
      t.string :country
      t.string :addresstype

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
