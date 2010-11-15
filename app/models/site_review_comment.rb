class SiteReviewComment < ActiveRecord::Base
    belongs_to :site_review
    belongs_to :commentor
    belongs_to :content
    
    accepts_nested_attributes_for :content
    accepts_nested_attributes_for :commentor
    accepts_nested_attributes_for :site_review
end
