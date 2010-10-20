class CreateAddressesStudentsJoin < ActiveRecord::Migration
  def self.up
    create_table 'addresses_students', :id => false do |t|
      t.integer 'address_id'
      t.integer 'student_id'
    end    
  end

  def self.down
    drop_table 'addresses_students'
  end
end
