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
  end

  def self.down
    drop_table :users
  end
end
