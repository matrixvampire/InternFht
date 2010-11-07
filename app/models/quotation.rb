class Quotation < ActiveRecord::Base
  validates_presence_of :author_name
  validates_presence_of :category
  validates_presence_of :quote

  validates_format_of :author_name,
                      :with => /^[A-Za-z. ]*$/i,
                      :message => "must only contain only letters."
end
