class AddRelatedtoToEvaluationEnquiries < ActiveRecord::Migration
  def self.up    
    add_column :evaluation_enquiries, :relatedto, :string
  end

  def self.down
    remove_column :evaluation_enquiries, :relatedto
  end
end
