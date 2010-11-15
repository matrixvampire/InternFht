 class Student < ActiveRecord::Base
  belongs_to :people
  has_and_belongs_to_many :addresses
  
  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :addresses
  
  has_many :internships
  has_many :sites, :through => :internships
  
  has_many :discussions
  
end
