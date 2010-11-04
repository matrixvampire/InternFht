class Site < ActiveRecord::Base
  has_and_belongs_to_many :addresses
  
  has_many  :sites_associations
  has_many  :peoples, :through  => :sites_associations
  
  accepts_nested_attributes_for :peoples
  accepts_nested_attributes_for :sites_associations
  accepts_nested_attributes_for :addresses
  
end
