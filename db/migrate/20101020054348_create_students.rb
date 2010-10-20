class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :identificationcode
      t.integer :people_id
      t.date :admissiondate      

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
