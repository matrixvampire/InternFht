class StudentEvaluation < ActiveRecord::Base
    belongs_to :evaluation_enquiry
    belongs_to :internship
end
