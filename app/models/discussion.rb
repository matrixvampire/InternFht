class Discussion < ActiveRecord::Base
    belongs_to :content
    belongs_to :student
    
    has_one :reply
end
