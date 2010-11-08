class Reply < ActiveRecord::Base
    belongs_to :content
    belongs_to :discussion
    belongs_to :commentor
    
    accepts_nested_attributes_for :content
    accepts_nested_attributes_for :commentor
    accepts_nested_attributes_for :discussion
end
