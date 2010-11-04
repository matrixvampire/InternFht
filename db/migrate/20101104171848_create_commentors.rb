class CreateCommentors < ActiveRecord::Migration
  def self.up
    create_table :commentors do |t|
      t.string :name
      t.string :email
      t.string :homepage
      t.integer :people_id

      t.timestamps
    end
  end

  def self.down
    drop_table :commentors
  end
end
