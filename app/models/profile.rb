class Profile < ActiveRecord::Base
  belongs_to :people, :foreign_key => "creator_id"
  
  has_many :profile_versions, :foreign_key => "latest_version_id"
end

