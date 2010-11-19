class Discussion < ActiveRecord::Base
    belongs_to :content
    belongs_to :student
    
    has_many :replies
    
    accepts_nested_attributes_for :content
    accepts_nested_attributes_for :student
    
    def self.new_by_student(params, user)
      discussion = self.new(params)
      discussion.student = user
      discussion.content = Content.new_need_approve(params)      
    end
end
