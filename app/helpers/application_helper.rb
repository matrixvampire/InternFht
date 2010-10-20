# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def nav_link( text, controller, action=:index )
    link_to_unless_current text, :controller => controller, :action => action
  end
  def logged_in?
    User.logged_in?( session )
  end  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "main"
  end
end
