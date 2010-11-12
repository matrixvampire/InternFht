class SiteReview < ActiveRecord::Base
    belongs_to :content
    belongs_to :internship
    
    has_many :site_review_comment
    
    accepts_nested_attributes_for :content
    accepts_nested_attributes_for :internship
end
