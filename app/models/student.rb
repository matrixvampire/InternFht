class Student < ActiveRecord::Base
  belongs_to :people
  has_and_belongs_to_many :addresses
end
