class DiscussionController < ApplicationController
  
  before_filter :protect, :only => [:create, :show, :comment, :edit]
  
  #  show all discussion...
  def show
    @title = "Discussion"
    @discussions = Discussion.find(:all, :order => 'created_at desc')
  end
  
  #  create new discussion
  def create
    @title = "Discussion"
    @subtitle = "add"
    if logged_in?      
      if request.post?
        @discussion = Discussion.new(params[:discussion])
        @discussion.content.contenttype = CONTENT_TYPE_DISCUSSION 
        @discussion.content.creationdate = Time.now
        @discussion.content.content_versions.first.contentstatus = CONTENT_STATUS_APPROVED
        @discussion.content.content_versions.first.versiondate = Time.now
        @discussion.content.content_versions.first.contentstatusdate = Time.now
        @discussion.student = get_user_student        
        
        ActiveRecord::Base.transaction do
          if @discussion.save
            c = Content.find(:last)
            c.latest_version_id = ContentVersion.find(:last).id
            if c.save # update latest version
              flash[:notice] = "Discussion created successfully!!!"
            else
              flash[:error] = "Some problem. Try later."
              raise ActiveRecord::Rollback
            end
          else
            flash[:error] = "Some problem. Try later."
            raise ActiveRecord::Rollback
          end
        end
        redirect_to :controller => :discussion, :action => :show
      else # do get...
        @discussion = Discussion.new
        @discussion.content = Content.new
        #      Tag should be make dynamic
        @discussion.content.tags << Tag.new
        
        @discussion.content.content_versions << ContentVersion.new
        
        @tags = Tag.find(:all, :select => 'DISTINCT tag_name', :order => 'tag_name')
      end
    end
  end
  
  #  give comment
  def comment
    @title = "Comment"
    if logged_in?      
      if request.post?
        @reply = Reply.new(params[:reply])
        @reply.commentor = get_commentor
        @reply.content.contenttype = CONTENT_TYPE_REPLY
        @reply.content.creationdate = Time.now
        @reply.content.content_versions.first.contentstatus = CONTENT_STATUS_APPROVED
        @reply.content.content_versions.first.versiondate = Time.now
        @reply.content.content_versions.first.contentstatusdate = Time.now
        @reply.discussion = Discussion.find(params[:reply][:discussion_id])
        
        ActiveRecord::Base.transaction do
          if @reply.save
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
      else #do_get 
        @discussion = Discussion.find(params[:id])
        logger.debug @discussion
        @replys = @discussion.replies
        
        @reply = Reply.new
        @reply.content = Content.new
        @reply.content.content_versions << ContentVersion.new
        @reply.discussion = @discussion
        #      Tag should be make dynamic
        #        @reply.content.tags << Tag.new
      end
    end
  end
  
  #  To show a list of discussion of particular student
  def showmine
    @title = "Discussion"
    student_id = get_user_student.id
    @discussions = Discussion.find(:all, :conditions => ["student_id = ?", student_id], :order => 'created_at desc')
  end
  
  
  #  to edit his own discussion
  def edit
    @title = "Discussion"
    if logged_in?      
      if request.post?
        if params[:content_version][:content_version_id].nil? #new version 
          @content_version = ContentVersion.new(params[:content_version])
          @content_version.contentstatus = CONTENT_STATUS_APPROVED
          @content_version.modifieddate = Time.now
          @content_version.contentstatusdate = Time.now
          ActiveRecord::Base.transaction do
            if @content_version.save
              c = Content.find(params[:content_version][:content_id])
              c.latest_version_id = ContentVersion.find(:last).id
              if c.save # update latest version
                flash[:notice] = "Discussion edited successfully!!!"
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
          if c.save # update latest version
            flash[:notice] = "Discussion edited successfully!!!"
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
    render :text => content_version.title+","+content_version.body+","+params[:id]
  end
  
  #  For set to be expired discussion
  def delete
    content = Content.find(params[:id])
    content_version =  ContentVersion.find(content.latest_version_id)
    content_version.contentstatus = CONTENT_STATUS_EXPIRED
    content_version.contentstatusdate = Time.now
    content_version.save
    redirect_to :action => :showmine
  end
end
