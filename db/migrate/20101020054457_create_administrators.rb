class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.string :identificationcode
      t.integer :people_id
      t.date :registereddate      

      t.timestamps
    end
  end

  def self.down
    drop_table :administrators
  end
end
