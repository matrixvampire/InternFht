class CreateSiteReviewComments < ActiveRecord::Migration
  def self.up
    create_table :site_review_comments do |t|
      t.integer :content_id
      t.integer :site_review_id
      t.integer :commentor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :site_review_comments
  end
end
