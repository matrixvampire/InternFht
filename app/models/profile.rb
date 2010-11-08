class Profile < ActiveRecord::Base
  belongs_to :people, :foreign_key => "creator_id"
  
  has_many :profile_versions, :order => "profile_version_id DESC"
end