class Internship < ActiveRecord::Base
    belongs_to :site
    belongs_to :student
    
    has_many :student_evaluations
    has_many :site_evaluations
    has_one :site_review
end
