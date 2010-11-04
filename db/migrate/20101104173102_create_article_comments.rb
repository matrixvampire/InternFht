class CreateArticleComments < ActiveRecord::Migration
  def self.up
    create_table :article_comments do |t|
      t.integer :content_id
      t.integer :article_id
      t.integer :commentor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :article_comments
  end
end
