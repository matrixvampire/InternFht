class Discussion < ActiveRecord::Base
    belongs_to :content
    belongs_to :student
    
    has_many :replies
    
    accepts_nested_attributes_for :content
    accepts_nested_attributes_for :student
end
