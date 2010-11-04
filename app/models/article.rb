class Article < ActiveRecord::Base
    belongs_to :content
    belongs_to :people
    
    has_one :article_comment
end
