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
  
  def is_admin?
    if session[:user_id] != nil
      if get_type_of_user == TYPE_ADMINISTRATOR
        return true
      end
    end 
    return false
  end
  
  def get_type_of_user
    if session[:user_id] != nil
      currentUser = User.find(session[:user_id])
      return currentUser.usertype
    end
    return nil
  end
  
  def get_name_of_user
    if session[:user_id] != nil
      currentUserDetail = People.find(session[:user_id])
      return currentUserDetail.firstname+" "+currentUserDetail.middlename+" "+currentUserDetail.lastname
    end
  end
  
end
