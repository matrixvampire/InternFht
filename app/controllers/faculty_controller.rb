class FacultyController < ApplicationController
  def profile
    @title = "Faculty Profile"
    @user = User.find(session[:user_id])
    @people = People.find_by_user_id(@user.id)
    @faculty = @people.faculty
  end

end
