class SiteController < ApplicationController
  before_filter :protect, :only => [:profile]
  
  def profile  
    @title = "Site People Profile"
    @user = User.find(session[:user_id])
    @people = People.find_by_user_id(@user.id)
  end
end
