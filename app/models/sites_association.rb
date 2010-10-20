class SitesAssociation < ActiveRecord::Base
  belongs_to :site
  belongs_to :people
end
