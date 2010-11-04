class Broadcast < ActiveRecord::Base
    belongs_to :administrator
    belongs_to :content
end
