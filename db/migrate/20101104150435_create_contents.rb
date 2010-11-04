class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :contenttype
      t.string :title
      t.text :body
      t.string :contentstatus
      t.datetime :creationdate
      t.datetime :approveddate

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
