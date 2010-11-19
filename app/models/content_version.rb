
class ContentVersion < ActiveRecord::Base
  belongs_to :content
  
  def new_need_approve(params)
    content_version = self.new(params)
    content_version.contentstatus = CONTENT_STATUS_APPROVED
    content_version.versiondate = Time.now
    content_version.contentstatusdate = Time.now
  end
end
