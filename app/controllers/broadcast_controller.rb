class BroadcastController < ApplicationController
  
  before_filter :protect, :only => [:create, :edit, :delete]
  
  def show
    @title = "News"    
    @broadcasts = Broadcast.find(:all, :order => 'created_at desc')
  end
  
  def create
    @title = "News"
    @subtitle = "add"
    if logged_in?      
      if request.post?
        @broadcast = Broadcast.new(params[:broadcast])
        
        @broadcast.content.content_versions.first.digest = get_content_digest(@broadcast.content.content_versions.first.body)
        
        @broadcast.releasedate = Time.now
        @broadcast.content.contenttype = CONTENT_TYPE_NEW 
        @broadcast.content.creationdate = Time.now
        @broadcast.content.content_versions.first.contentstatus = CONTENT_STATUS_APPROVED
        @broadcast.content.content_versions.first.versiondate = Time.now
        @broadcast.content.content_versions.first.contentstatusdate = Time.now
        @broadcast.administrator = get_user_administrator        
        
        ActiveRecord::Base.transaction do
          if @broadcast.save
            c = Content.find(:last)
            c.latest_version_id = ContentVersion.find(:last).id
            if c.save # update latest version
              flash[:notice] = "News created successfully!!!"
            else
              flash[:error] = "Some problem. Try later."
              raise ActiveRecord::Rollback
            end
          else
            flash[:error] = "Some problem. Try later."
            raise ActiveRecord::Rollback
          end
        end
        redirect_to :action => :show
      else # DO_GET
        @broadcast = Broadcast.new
        @broadcast.content = Content.new
        #      Tag should be make dynamic
        @broadcast.content.tags << Tag.new
        
        @broadcast.content.content_versions << ContentVersion.new
        
      end
    end
  end
  
  def edit
    @title = "News"
    @subtitle = "edit"
    if logged_in?      
      if request.post?
        if params[:content_version][:content_version_id].nil? #new version 
          @content_version = ContentVersion.new(params[:content_version])
          @content_version.digest = get_content_digest(@content_version.body)
          @content_version.contentstatus = CONTENT_STATUS_APPROVED
          @content_version.versiondate = Time.now
          @content_version.contentstatusdate = Time.now
          new = @content_version.content.broadcast
          new.expirationdate = params[:date][:year]+"-"+params[:date][:month]+"-"+params[:date][:day]
          ActiveRecord::Base.transaction do
            if @content_version.save and new.save
              c = Content.find(params[:content_version][:content_id])
              c.latest_version_id = ContentVersion.find(:last).id
              if c.save # update latest version
                flash[:notice] = "News edited successfully!!!"
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
            flash[:notice] = "News edited successfully!!!"
          else
            flash[:error] = "Some problem. Try later."
          end
        end
        redirect_to :action => :show
        
      else #DO_GET
        content = Content.find(params[:id])  
        @broadcast = content.broadcast
        @content_version =  ContentVersion.find(content.latest_version_id)
        @all_versions = ContentVersion.find(:all, :conditions => ["content_id = ? and id <> ? ", content.id, content.latest_version_id], :order => 'created_at desc')
      end
    end
  end
  
  #  For AJAX request to get previous version
  def get_previous_version
    content_version = ContentVersion.find(params[:id])
    render :text => content_version.title+"||"+content_version.body+"||"+params[:id]
  end
  
  def delete
      content = Content.find(params[:id])
      content_detail = ContentVersion.find(content.latest_version_id)
      
      content_detail.contentstatus = CONTENT_STATUS_EXPIRED
      content_detail.contentstatusdate = Time.now
      
      if content_detail.save
        flash[:notice] = "News deleted succesfully!!!"
      else
        flash[:error] = "Some problem. Try later."
      end
      redirect_to :action => :show
  end
  
  def showdetail
    @title = "News"
    @subtitle = "detail"
    if logged_in?
      @broadcast = Broadcast.find(params[:id])
      @content = @broadcast.content
      @content_version =  ContentVersion.find(@content.latest_version_id)
    end
  end
  
end
