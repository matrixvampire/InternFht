class SiteReviewComment < ActiveRecord::Base
    belongs_to :site_review
    belongs_to :commentor
    belongs_to :content
end
