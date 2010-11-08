class StudentController < ApplicationController
  
  before_filter :protect, :only => [:profile]
  
  def profile  
    @title = "Student Profile"
    @user = User.find(session[:user_id])
    @people = People.find_by_user_id(@user.id)
    @student = @people.student
  end

  def mydiscussions
    redirect_to :controller => :discussion, :action => :show
  end
end
