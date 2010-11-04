class Commentor < ActiveRecord::Base
    has_one :reply
    belongs_to :people
    has_one :article_comment
    has_one :site_review_comment
end
