class Content < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  has_many :content_versions, :order => "content_version_id DESC"
  
  has_one :broadcast, :dependent => :nullify
  has_one :discussion, :dependent => :nullify
  has_one :article, :dependent => :nullify
  has_one :article_comment, :dependent => :nullify
  has_one :site_review, :dependent => :nullify
  has_one :site_review_comment, :dependent => :nullify
end
