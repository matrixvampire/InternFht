class Content < ActiveRecord::Base
    has_and_belongs_to_many :tags
    
    has_many :broadcasts
    has_many :administrators, :through => :broadcasts
    
    has_one :discussion
    has_one :article
    has_one :article_comment
    has_one :site_review
    has_one :site_review_comment
end
