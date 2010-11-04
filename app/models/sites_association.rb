class SitesAssociation < ActiveRecord::Base
  belongs_to :site
  belongs_to :people
  
  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :site
end
