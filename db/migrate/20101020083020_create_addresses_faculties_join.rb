class CreateAddressesFacultiesJoin < ActiveRecord::Migration
  def self.up
    create_table 'addresses_faculties', :id => false do |t|
      t.integer 'address_id'
      t.integer 'faculty_id'
    end    
  end

  def self.down
    drop_table 'addresses_faculties'
  end
end
