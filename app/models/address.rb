class Address < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_and_belongs_to_many :sites
  has_and_belongs_to_many :faculties
  has_and_belongs_to_many :administrators
  
  validates_presence_of :city, :country
  
  def fulladdress
    self.city + " " + self.country
  end
end
