class Administrator < ActiveRecord::Base
  belongs_to :people
  has_and_belongs_to_many :addresses
 
  has_many :broadcasts
  has_many :contents, :through => :broadcasts
end
