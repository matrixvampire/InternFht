class SiteEvaluationController < ApplicationController
  
  before_filter :protect, :only => [:index, :create, :show]
  
  def index
    @title = "Site Evaluation"
    @internships = get_student_internships
  end
  
  def create
    @title = "Site Evaluation"
    if logged_in?      
      if request.post?
        @internship = Internship.find(params[:id])
        @internship.isevaluate = true
        @internship.update_attributes(params[:internship])
        redirect_to :action => :index        
      else
        if(params[:id])
          @internship = Internship.find(params[:id])
          @siteevaluationenquiries = EvaluationEnquiry.find(:all, :conditions => "relatedto = 'Site'")
          @internship.site_evaluations.build
          #          @siteevaluationenquiries.each do |enquiry|
          #            siteevaluation = SiteEvaluation.new            
          #            siteevaluation.evaluation_enquiry = enquiry
          #            siteevaluation.evaluationdate = Time.now
          #            # Approved when submitted
          #            siteevaluation.approvalstatus = CONTENT_STATUS_APPROVED
          #            siteevaluation.approveddate = Time.now
          #            @internship.site_evaluations << siteevaluation
          #          end          
        end
      end
    end
  end
  
  def show
    @title = "Site Evaluation"
    if (params[:id])
      @internship = Internship.find(params[:id])
    end
  end
    
end
