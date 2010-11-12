class SiteReviewController < ApplicationController
  before_filter :protect, :only => [:create, :showforadmin, :givereason, :setstatus, :showmine]
  
  #  show all discussion...
  def show
    @title = "Site Review"
    site_reviews = SiteReview.find(:all, :order => 'created_at desc')
    @content_details = Array.new
    if !site_reviews.nil?
      site_reviews.each do |review|
        content_detail = ContentVersion.find(review.content.latest_version_id)
        if content_detail.contentstatus == CONTENT_STATUS_APPROVED
          @content_details << content_detail
        end
      end
    end
  end
  
  def showforadmin
    @title = "Site Review"
    @subtitle = "for administrator"
    if logged_in?  
      if !(is_admin?)
        redirect_to :action => :show
      end
      if request.post?
        if !params[:type].nil?
          site_reviews = SiteReview.find(:all, :order => 'created_at desc')
          @content_details = Array.new
          if !site_reviews.nil?
            site_reviews.each do |review|
              content_detail = ContentVersion.find(review.content.latest_version_id)
              if content_detail.contentstatus == params[:type]
                @content_details << content_detail
              end
            end
          end
        end
      else #DO_GET
      
      end
    end
  end
  
  def create 
    @title = "Site Review"
    @subtitle = "add"
    if logged_in?    
      @internships = get_not_review_yet
      if request.post?
        @site_review = SiteReview.new(params[:site_review])
        @site_review.content.contenttype = CONTENT_TYPE_SITE_REVIEW 
        @site_review.content.creationdate = Time.now
        @site_review.content.content_versions.first.contentstatus = CONTENT_STATUS_SUBMITED
        @site_review.content.content_versions.first.versiondate = Time.now
        @site_review.content.content_versions.first.contentstatusdate = Time.now
        
        ActiveRecord::Base.transaction do
          if @site_review.save
            c = Content.find(:last)
            c.latest_version_id = ContentVersion.find(:last).id
            
            intern = Internship.find(@site_review.internship_id)
            intern.isreview = true
            if c.save and intern.save # update latest version and isreview status
              flash[:notice] = "Site Review created successfully!!!"
            else
              flash[:error] = "Some problem. Try later."
              raise ActiveRecord::Rollback
            end
          else
            flash[:error] = "Some problem. Try later."
            raise ActiveRecord::Rollback
          end
        end
        redirect_to :controller => :site_review, :action => :show
      else # DO_GET
        @site_review = SiteReview.new
        @site_review.content = Content.new
        #      Tag should be make dynamic
        @site_review.content.tags << Tag.new
        
        @site_review.content.content_versions << ContentVersion.new
        
        @tags = Tag.find(:all, :select => 'DISTINCT tag_name', :order => 'tag_name')
      end
    end
  end
  
  def givereason
    @title = "Site Review"
    @subtitle = "need amending"
    if logged_in?    
      if request.post?
        content = Content.find(params[:content_id])
        content_detail = ContentVersion.find(content.latest_version_id)
        smtp_result = Verifier.need_amend(content, content_detail, params[:reason]) 
        
        content_detail.contentstatus = CONTENT_STATUS_AMENDED
        if content_detail.save
          flash[:notice] = "An email has been sent to an user!!"
        else
          flash[:error] = "Some problem. Try later."
        end
        redirect_to :action => :showforadmin
      else # DO_GET
        content = Content.find(params[:id])
        @content_detail = ContentVersion.find(content.latest_version_id)
      end
    end
  end
  
  def setstatus
      content = Content.find(params[:id])
      content_detail = ContentVersion.find(content.latest_version_id)
      smtp_result = Verifier.set_new_status(content, content_detail, params[:status]) 
      
      content_detail.contentstatus = params[:status]
      if content_detail.save
        flash[:notice] = "An email has been sent to an user!!"
      else
        flash[:error] = "Some problem. Try later."
      end
      redirect_to :action => :showforadmin
  end
  
  def showmine
    @title = "Site Review"
    @subtitle = "show mine"
    student_id = get_user_student.id
    internships = Internship.find(:all, :conditions => ["student_id = ? and isreview = ?", student_id, true], :order => 'startdate desc')
    @content_details = Array.new
    if !internships.nil?
      internships.each do |intern|
        content_detail = ContentVersion.find(intern.site_review.content.latest_version_id)
        status = content_detail.contentstatus
        if status == CONTENT_STATUS_APPROVED or status == CONTENT_STATUS_SUBMITED or status == CONTENT_STATUS_AMENDED
          @content_details << content_detail
        end
      end
    end
  end
end
