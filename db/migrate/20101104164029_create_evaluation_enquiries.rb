class CreateEvaluationEnquiries < ActiveRecord::Migration
  def self.up
    create_table :evaluation_enquiries do |t|
      t.integer :evaluation_criteria_id
      t.string :question
      t.string :relatedto
      t.timestamps
    end
  end

  def self.down
    drop_table :evaluation_enquiries
  end
end
