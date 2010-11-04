class CreateSiteReviews < ActiveRecord::Migration
  def self.up
    create_table :site_reviews do |t|
      t.integer :content_id
      t.integer :internship_id

      t.timestamps
    end
  end

  def self.down
    drop_table :site_reviews
  end
end
