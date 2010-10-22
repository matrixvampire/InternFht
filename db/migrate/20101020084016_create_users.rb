class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password_salt
      t.string :password_hash
      t.string :usertype
      t.boolean :isvalid
      t.string :validation_code
      t.date :validity_period
    end
    
    add_index :users, :username, :unique => true, :name => 'username_index'
    
  end

  def self.down
    drop_table :users
    remove_index :users, 'username_index'
  end
end
