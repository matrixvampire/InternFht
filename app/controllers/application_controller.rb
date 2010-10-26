# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # ssl_requirement flip to https when appropriate
  include SslRequirement
  # Mix in the methods from the ApplicationHelper module
  include ApplicationHelper
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  filter_parameter_logging :old_password
  filter_parameter_logging :new_password
  filter_parameter_logging :confirm_password
  
  # Protect a page from unauthorized access.
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "Please log in first"
      redirect_to :controller => "user", :action => "login"
      return false
    end
  end
  
  # Override ssl_required? only to Production Environment
  def ssl_required?
    return false if local_request? || RAILS_ENV == 'test'
    super
  end
  
end
