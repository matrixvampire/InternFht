class EvaluationEnquiry < ActiveRecord::Base
    belongs_to :evaluation_criteria
    
    has_one :student_evaluation
    has_one :site_evaluation
end
