class AddIsevaluateToInternships < ActiveRecord::Migration
  def self.up
    add_column :internships, :isevaluate, :boolean
  end

  def self.down
    remove_column :internships, :isevaluate
  end
end
