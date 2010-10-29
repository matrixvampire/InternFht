class People < ActiveRecord::Base
  has_one :administrator
  has_one :faculty  
  has_one :student
  
  belongs_to :user
  
  has_many  :site_associations
  has_many  :sites, :through  => :site_associations
  
  #Validation
  validates_presence_of :firstname, :lastname, :emailaddress, :gender
  
  #validates_uniqueness_of :emailaddress
  
  validates_format_of :emailaddress, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i
  
  accepts_nested_attributes_for :user
  
  def fullname
    self.firstname + " " + self.middlename + " " + self.lastname 
  end
end