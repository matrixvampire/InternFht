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
  end

  def self.down
    drop_table :peoples
  end
end
