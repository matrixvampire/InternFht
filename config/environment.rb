# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# force Rails into production mode when                          
# you don't control web/app server and can't set it the proper way                  
# ENV['RAILS_ENV'] ||= 'production'

# ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => '%d-%m-%Y %H:%M:%S')

# Domain Name: localhost
ENV['RECAPTCHA_PUBLIC_KEY']  = '6LdUcr4SAAAAAM4BhOR1-Te44lICGI61c_So73g6'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6LdUcr4SAAAAANvIqNTCNcG1YYva2SMS-g5EO3fh'

# Domain Name:  web4.cs.ait.ac.th
# ENV['RECAPTCHA_PUBLIC_KEY']  = '6LdLcr4SAAAAAHnb1HN9foxbOMMnnBBA6Y_7N-wM'
# ENV['RECAPTCHA_PRIVATE_KEY'] = '6LdLcr4SAAAAADhuX3oeEnVTj9RgZaXL6IwGMKRJ'

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  # config.gem "ambethia-recaptcha", :lib => "recaptcha/rails", :source => "http://gems.github.com"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  
  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
  
  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  
  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  
  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  config.logger = Logger.new(STDOUT)
  
  APPLICATION_NAME = 'Internship Office'  
  AUTHOR_NAME = 'FHT PSU'
  AUTHOR_EMAIL = 'intern@fht.psu.ac.th'
  AUTHORSHIP_YEAR = '2010'
  
  TYPE_ADMINISTRATOR = 'Administrator'
  TYPE_FACULTY = 'Faculty'
  TYPE_STUDENT = 'Student'
  TYPE_SITE = 'Site'
  
  CONTENT_TYPE_DISCUSSION = 'Discussion'
  CONTENT_TYPE_REPLY = 'Reply'
  CONTENT_TYPE_ARTICLE = 'Article'
  CONTENT_TYPE_SITE_REVIEW = 'Site Review'
  CONTENT_TYPE_NEW = 'New'
  CONTENT_TYPE_ARTICLE_COMMENT = 'Article Comment'
  CONTENT_TYPE_SITE_REVIEW_COMMENT = 'Site Review Comment'
  
  CONTENT_STATUS_SUBMITED = 'Submited'
  CONTENT_STATUS_AMENDED = 'Amended'
  CONTENT_STATUS_APPROVED = 'Approved'
  CONTENT_STATUS_REJECTED = 'Rejected'
  CONTENT_STATUS_EXPIRED = 'Expired'
  
  REQUIRED_DURATION_FOR_REVIEW = 1
  
  NUMBER_OF_WORDS_FOR_DIGEST = 25
  
  require 'builder'
  
  #Set date farmat for calendar
  #  ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  ##    :default => '%d %b %Y' # 05 Oct 2010
  ##    :default => '%d-%B-%Y' # 05 October 2010
  ##    :default => '%d/%m/%Y ' # 19/10/2010
  #    :default => '%Y-%m-%d' # 2010-10-27
  #  )
  
end