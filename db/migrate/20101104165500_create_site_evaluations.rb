class CreateSiteEvaluations < ActiveRecord::Migration
  def self.up
    create_table :site_evaluations do |t|
      t.integer :internship_id
      t.integer :evaluation_enquiry_id
      t.integer :point
      t.text :comment
      t.date :evaluationdate
      t.string :approvalstatus
      t.date :approveddate

      t.timestamps
    end
  end

  def self.down
    drop_table :site_evaluations
  end
end
