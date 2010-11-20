class SiteController < ApplicationController
  before_filter :protect, :only => [:profile, :myevaluations, :studentevaluations, :showevaluate, :createevaluate]
  
  def profile  
    @title = "Site People Profile"
    @user = User.find(session[:user_id])
    @people = People.find_by_user_id(@user.id)
    @site = get_site
  end
  
  def myevaluations
    @title = "Evaluation"
    @site = get_site
  end
  
  def studentevaluations
    @title = "Student Evaluation"
    @site = get_site
  end
  
  def showevaluate
    @title = "Student Evaluation"
    if (params[:id])
      @internship = Internship.find(params[:id])
    end
  end
  
  def createevaluate
    @title = "Student Evaluation"
    if logged_in?
      if request.post?
        @internship = Internship.find(params[:id])
        @internship.update_attributes(params[:internship])
        redirect_to :action => :studentevaluations
      else
        if (params[:id])
          @internship = Internship.find(params[:id])
          @studentevaluationenquires = EvaluationEnquiry.find(:all, :conditions => "relatedto = 'Student'")
          @internship.student_evaluations.build
        end
      end
    end
  end
  
  def myreviews
    @title = "Review"
    flash[:notice] = "There is no any review"
    @site = get_site
    internships = Internship.find(:all, :conditions => ["site_id = ? and isreview = ?", @site.id, true], :order => 'startdate desc')
    @content_details = Array.new
    if !internships.nil?
      internships.each do |intern|
        content_detail = ContentVersion.find(intern.site_review.content.latest_version_id)
        status = content_detail.contentstatus
        if status == CONTENT_STATUS_APPROVED
          @content_details << content_detail
          flash[:notice] = ""
        end
      end
    end
  end
end
