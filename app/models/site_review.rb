class SiteReview < ActiveRecord::Base
    belongs_to :content
    belongs_to :internship
    
    has_one :site_review_comment
end
