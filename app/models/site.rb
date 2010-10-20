class Site < ActiveRecord::Base
  has_and_belongs_to_many :addresses
  
  has_many  :site_associations
  has_many  :peoples, :through  => :site_associations
end
