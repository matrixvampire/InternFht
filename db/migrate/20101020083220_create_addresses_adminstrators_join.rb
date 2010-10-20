class CreateAddressesAdminstratorsJoin < ActiveRecord::Migration
  def self.up
    create_table 'addresses_administrators', :id => false do |t|
      t.integer 'address_id'
      t.integer 'administrator_id'
    end    
  end

  def self.down
    drop_table 'addresses_administrators'
  end
end
