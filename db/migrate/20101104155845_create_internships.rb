class CreateInternships < ActiveRecord::Migration
  def self.up
    create_table :internships do |t|
      t.integer :student_id
      t.integer :site_id
      t.string :sector
      t.date :startdate
      t.date :enddate
      t.boolean :isreview

      t.timestamps
    end
  end

  def self.down
    drop_table :internships
  end
end
