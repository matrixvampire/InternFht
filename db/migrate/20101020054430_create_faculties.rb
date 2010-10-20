class CreateFaculties < ActiveRecord::Migration
  def self.up
    create_table :faculties do |t|
      t.string :identificationcode
      t.integer :people_id
      t.string :jobtitle
      t.date :joindate      

      t.timestamps
    end
  end

  def self.down
    drop_table :faculties
  end
end
