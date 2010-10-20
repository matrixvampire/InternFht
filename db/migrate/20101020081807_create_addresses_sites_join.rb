class CreateAddressesSitesJoin < ActiveRecord::Migration
  def self.up
    create_table 'addresses_sites', :id => false do |t|
      t.integer 'address_id'
      t.integer 'site_id'
    end    
  end
  
  def self.down
    drop_table 'addresses_sites'
  end
end
