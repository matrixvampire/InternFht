class CreateQuotations < ActiveRecord::Migration
  def self.up
    create_table :quotations do |t|
      t.string :author_name
      t.string :category
      t.text :quote

      t.timestamps
    end
  end

  def self.down
    drop_table :quotations
  end
end
