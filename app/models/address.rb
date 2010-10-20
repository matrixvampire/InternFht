class Address < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_and_belongs_to_many :sites
  has_and_belongs_to_many :faculties
  has_and_belongs_to_many :administrators
end
