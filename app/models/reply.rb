class Reply < ActiveRecord::Base
    belongs_to :content
    belongs_to :discussion
    belongs_to :commentor
end
