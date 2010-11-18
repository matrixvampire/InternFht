class Broadcast < ActiveRecord::Base
    belongs_to :administrator
    belongs_to :content
    
    accepts_nested_attributes_for :content
    accepts_nested_attributes_for :administrator
end
