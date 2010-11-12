class StudentController < ApplicationController
  
  before_filter :protect, :only => [:profile]
  
  def profile  
    @title = "Student Profile"
    @user = User.find(session[:user_id])
    @people = People.find_by_user_id(@user.id)
    @student = @people.student
  end

  def discussions
    redirect_to :controller => :discussion, :action => :show
  end
  
  def reviews
    redirect_to :controller => :site_review, :action => :show
  end
  
end
