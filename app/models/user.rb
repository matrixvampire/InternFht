class User < ActiveRecord::Base
  has_one :people
  has_many :user_logs
  
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 20  
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  
  # Simple validations
  validates_uniqueness_of :username  
  validates_format_of :username, :with => /^[A-Z0-9_]*$/i, :message => "must contain only letters, " + "numbers, and underscores"    
  
  attr_accessor :password
  
  attr_accessible :username, :password, :usertype, :isvalid
  
  def password=(pass)
    self.password_salt, self.password_hash = nil, nil
    if pass && pass.length >= PASSWORD_MIN_LENGTH
      salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
      self.password_salt, self.password_hash =
      salt, Digest::SHA1.hexdigest(pass + salt)
    end
  end
  
  def validate
    if self.password_salt.nil? || self.password_hash.nil?
      errors.add_to_base "Invalid password"
    end
  end  
  
  def self.logged_in?( session )
    not session[:user_id].nil?
  end
  
  def authenticate( password )
    if Digest::SHA1.hexdigest( password + self.password_salt ) !=
      self.password_hash
      return nil
    end
    self
  end  
  
  def login!( session )
    session[:user_id] = id
  end
end
