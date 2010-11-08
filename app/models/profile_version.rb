class ProfileVersion < ActiveRecord::Base
  belongs_to :profile
  
  belongs_to :people, :foreign_key => "alteredby_id"
end
