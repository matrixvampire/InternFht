class SiteEvaluationController < ApplicationController
  
  def create
    @title = "Site Evaluation"
    if logged_in?      
      if request.post?
        # Do Something
      else
        # Get Individual Internship information
        # Create array of siteevaluation
        # bind it with internship
        # call its save
#        @internships = get_review_done
#        @siteevaluationenquiries = EvaluationEnquiry.find_by_relatedto("Site")
#        @siteevaluations = Array.new
#        @internships.each do |internship|
#          @siteevaluationenquiries.each do |enquiry|
#            siteevaluation = SiteEvaluation.new
#            siteevaluation.internship = internship
#            siteevaluation.evaluation_enquiry = enquiry
#            @siteevaluations << siteevaluation
#          end
#        end
      end
    end
  end
  
  def edit
    @title = "Site Evaluation"
  end
  
  def comment
    @title = "Site Evaluation"
  end
  
  def show
    @title = "Site Evaluation"
  end
  
  def givereason
    @title = "Site Evaluation"
  end
  
end
