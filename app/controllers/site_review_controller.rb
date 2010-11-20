class SiteReviewController < ApplicationController
  before_filter :protect, :only => [:create, :showforadmin, :givereason, :setstatus, :showmine, :edit, :delete_comment]
  
  #  show all discussion...
  def show
    @internships = get_not_review_yet
    flash[:notice] = "There is no any review "
    @title = "Site Review"
    site_reviews = SiteReview.find(:all, :order => 'created_at desc')
    @content_details = Array.new
    if !site_reviews.nil?
      site_reviews.each do |review|
        content_detail = ContentVersion.find(review.content.latest_version_id)
        if content_detail.contentstatus == CONTENT_STATUS_APPROVED
          @content_details << content_detail
          flash[:notice] = ""
        end
      end
    end
  end
  
  def showforadmin
    @title = "Site Review"    
    if logged_in?  
      if !(is_admin?)
        redirect_to :action => :show
      end
      if !params[:type].nil?
        flash[:notice] = "There is no review status : "+params[:type]
      end
      @type = params[:type];
      if request.post?
        if !params[:type].nil?
          site_reviews = SiteReview.find(:all, :order => 'created_at desc')
          @content_details = Array.new
          if !site_reviews.nil?
            site_reviews.each do |review|
              content_detail = ContentVersion.find(review.content.latest_version_id)
              if content_detail.contentstatus == params[:type]
                @content_details << content_detail
                flash[:notice] = "";
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
    if logged_in?    
      @internships = get_not_review_yet
      if request.post?
        @site_review = SiteReview.new(params[:site_review])
        @site_review.content.contenttype = CONTENT_TYPE_SITE_REVIEW 
        @site_review.content.creationdate = Time.now
        @site_review.content.content_versions.first.contentstatus = CONTENT_STATUS_SUBMITED
        @site_review.content.content_versions.first.versiondate = Time.now
        @site_review.content.content_versions.first.contentstatusdate = Time.now
        @site_review.content.content_versions.first.digest = get_content_digest(@site_review.content.content_versions.first.body)
        tag = Tag.new
        tag.tag_name = "review"
        @site_review.content.tags << tag
        
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
        
        @site_review.content.content_versions << ContentVersion.new
        
        @tags = Tag.find(:all, :select => 'DISTINCT tag_name', :order => 'tag_name')
      end
    end
  end
  
  def givereason
    @title = "Site Review"
    @subtitle = "Need Amending"
    if logged_in?    
      if request.post?
        content = Content.find(params[:content_id])
        content_detail = ContentVersion.find(content.latest_version_id)
        smtp_result = Verifier.deliver_need_amend(content, content_detail, params[:reason]) 
        
        content_detail.contentstatus = CONTENT_STATUS_AMENDED
        if content_detail.save
          flash[:notice] = "An email has been sent to an user!!"
        else
          flash[:error] = "Some problem. Try later."
        end
        redirect_to :action => :showforadmin
      else # DO_GET
        @content = Content.find(params[:id])
        @content_detail = ContentVersion.find(@content.latest_version_id)
      end
    end
  end
  
  def setstatus
      content = Content.find(params[:id])
      content_detail = ContentVersion.find(content.latest_version_id)
      
      content_detail.contentstatus = params[:status]
      content_detail.contentstatusdate = Time.now
      
      if is_admin?
        smtp_result = Verifier.deliver_set_new_status(content.site_review.internship.student.people, content_detail, params[:status]) 
        if content_detail.save
          flash[:notice] = "An email has been sent to an user!!"
        else
          flash[:error] = "Some problem. Try later."
        end
        redirect_to :action => :showforadmin
      else 
        if content_detail.save
          flash[:notice] = "Site review deleted successfully!!!"
        else
          flash[:error] = "Some problem. Try later."
        end
        redirect_to :action => :showmine
      end
      
  end
  
  def showmine
    @internships = get_not_review_yet
    flash[:notice] = "There is no your review "
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
          flash[:notice] = ""
        end
      end
    end
  end
  
  def edit
    @title = "Site Review"
    @subtitle = "edit"
    if logged_in? 
      @internships = get_not_review_yet
      if request.post?
        if params[:content_version][:content_version_id].nil? #new version 
          @content_version = ContentVersion.new(params[:content_version])
          @content_version.contentstatus = CONTENT_STATUS_SUBMITED
          @content_version.versiondate = Time.now
          @content_version.contentstatusdate = Time.now
          @content_version.digest = get_content_digest(@content_version.body)
          
          ActiveRecord::Base.transaction do
            if @content_version.save
              c = Content.find(params[:content_version][:content_id])
              c.latest_version_id = ContentVersion.find(:last).id
              if c.save # update latest version
                flash[:notice] = "Site review edited successfully!!!"
              else
                flash[:error] = "Some problem. Try later."
                raise ActiveRecord::Rollback
              end
            else
              flash[:error] = "Some problem. Try later."
              raise ActiveRecord::Rollback
            end
          end
          
        else #use previous version 
          c = Content.find(params[:content_version][:content_id])
          c.latest_version_id = params[:content_version][:content_version_id]
          logger.debug params[:content_version][:content_version_id]
          if c.save # update latest version
            flash[:notice] = "Site review edited successfully!!!"
          else
            flash[:error] = "Some problem. Try later."
          end
        end
        redirect_to :action => :showmine
      else # do_get
        content = Content.find(params[:id])  
        @content_version =  ContentVersion.find(content.latest_version_id)
        @all_versions = ContentVersion.find(:all, :conditions => ["content_id = ? and id <> ? ", content.id, content.latest_version_id], :order => 'created_at desc')
        logger.debug @all_versions
      end
    end
  end
  
  #  For AJAX request to get previous version
  def get_previous_version
    content_version = ContentVersion.find(params[:id])
    render :text => content_version.title+"||"+content_version.body+"||"+params[:id]
  end
  
  def comment
    @title = "Site Review"
    @subtitle = "comment"
    if logged_in?     
      @internships = get_not_review_yet
      if request.post?
        @comment = SiteReviewComment.new(params[:comment])
        @comment.commentor = get_commentor
        @comment.content.contenttype = CONTENT_TYPE_SITE_REVIEW_COMMENT
        @comment.content.creationdate = Time.now
        @comment.content.content_versions.first.contentstatus = CONTENT_STATUS_APPROVED
        @comment.content.content_versions.first.versiondate = Time.now
        @comment.content.content_versions.first.contentstatusdate = Time.now
        @comment.site_review = SiteReview.find(params[:comment][:site_review_id])
        
        smtp_result = Verifier.deliver_comment_review(@comment.commentor.people.firstname, @comment.site_review, @comment.content.content_versions.first.body)
        
        ActiveRecord::Base.transaction do
          if @comment.save
            c = Content.find(:last)
            c.latest_version_id = ContentVersion.find(:last).id
            if c.save # update latest version
              flash[:notice] = "Comment added successfully!!!"
            else
              flash[:error] = "Some problem. Try later."
              raise ActiveRecord::Rollback
            end
          else
            flash[:error] = "Some problem. Try later."
            raise ActiveRecord::Rollback
          end
        end
        redirect_to :action => :comment
      else #DO_GET
        @review = SiteReview.find(params[:id])
        logger.debug @review
        @comments = @review.site_review_comments
        
        @comment = SiteReviewComment.new
        @comment.content = Content.new
        @comment.content.content_versions << ContentVersion.new
        @comment.site_review = @review
      end
    
    else #for viewer : do the same without commentor part
      if request.post?
        if !verify_recaptcha(@quotation)
          flash[:error] = "Please verify the captcha."
        end
        @comment = SiteReviewComment.new(params[:comment])
        @comment.content.contenttype = CONTENT_TYPE_SITE_REVIEW_COMMENT
        @comment.content.creationdate = Time.now
        @comment.content.content_versions.first.contentstatus = CONTENT_STATUS_APPROVED
        @comment.content.content_versions.first.versiondate = Time.now
        @comment.content.content_versions.first.contentstatusdate = Time.now
        @comment.site_review = SiteReview.find(params[:comment][:site_review_id])
        
        smtp_result = Verifier.deliver_comment_review(@comment.commentor.name, @comment.site_review, @comment.content.content_versions.first.body)
        
        ActiveRecord::Base.transaction do
          if @comment.save
            c = Content.find(:last)
            c.latest_version_id = ContentVersion.find(:last).id
            if c.save # update latest version
              flash[:notice] = "Comment added successfully!!!"
            else
              flash[:error] = "Some problem. Try later."
              raise ActiveRecord::Rollback
            end
          else
            flash[:error] = "Some problem. Try later."
            raise ActiveRecord::Rollback
          end
        end
        redirect_to :action => :comment
      else #DO_GET
        @review = SiteReview.find(params[:id])
        logger.debug @review
        @comments = @review.site_review_comments
        
        @comment = SiteReviewComment.new
        @comment.content = Content.new
        @comment.content.content_versions << ContentVersion.new
        @comment.site_review = @review
        @comment.commentor = Commentor.new
      end
    end
  end
  
  def delete_comment
      content = Content.find(params[:id])
      content_detail = ContentVersion.find(content.latest_version_id)
      
      content_detail.contentstatus = CONTENT_STATUS_EXPIRED
      content_detail.contentstatusdate = Time.now
      
      if content_detail.save
        flash[:notice] = "Comment deleted succesfully!!!"
      else
        flash[:error] = "Some problem. Try later."
      end
      redirect_to :action => :showforadmin
  end
  
  def showdetail
    @title = "Site Review"    
    @site_review = SiteReview.find(params[:id])
    @subtitle = @site_review.internship.site.sitename
    @content = @site_review.content
    @content_version =  ContentVersion.find(@content.latest_version_id)
  end
    
end
