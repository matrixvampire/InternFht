class CreateStudentEvaluations < ActiveRecord::Migration
  def self.up
    create_table :student_evaluations do |t|
      t.integer :internship_id
      t.integer :evaluation_enquiry_id
      t.integer :point
      t.text :comment
      t.date :evaluationdate

      t.timestamps
    end
  end

  def self.down
    drop_table :student_evaluations
  end
end
