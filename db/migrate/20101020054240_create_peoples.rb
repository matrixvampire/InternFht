class CreatePeoples < ActiveRecord::Migration
  def self.up
    create_table :peoples do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :nickname
      t.integer :user_id
      t.string :emailaddress
      t.string :phonenumber
      t.string :mobilenumber
      t.string :faxnumber
      t.string :birthdate
      t.date :birthdate_ad
      t.string :gender
      t.string :homepage
      t.binary :photo      
    end
    
    add_index :peoples, :user_id, :unique => true, :name => 'user_id_index'
    add_index :peoples, :firstname, :name => 'firstname_index'
    add_index :peoples, :lastname, :name => 'lastname_index'
    
  end
  def self.down
    drop_table :peoples
    remove_index :peoples, 'user_id_index'
    remove_index :peoples, 'firstname_index'
    remove_index :peoples, 'lastname_index'
  end
end
