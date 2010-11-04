class ArticleComment < ActiveRecord::Base
    belongs_to :content
    belongs_to :article
    belongs_to :commentor
end
