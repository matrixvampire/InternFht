# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def nav_link( text, controller, action=:index )
    link_to_unless_current text, :controller => controller, :action => action
  end
  
  def sortable(title, column, currentpage)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :showlist => currentpage}
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
  
  def check_session?
    if session[:user_id].nil?
      return false
    end
    return true
  end
  
  def is_student?    
    if check_session? && get_type_of_user == TYPE_STUDENT
      return true
    end    
    return false
  end
  
  def is_faculty?
    if check_session? && get_type_of_user ==TYPE_FACULTY
      return true
    end
    return false
  end
  
  
  def get_commentor
    if session[:user_id] != nil
      currentUserDetail = People.find(session[:user_id])
      commentor = Commentor.new
      commentor.people = currentUserDetail
      return commentor
    end
    return nil
  end
  
  
  def is_site?
    if check_session? && get_type_of_user ==TYPE_SITE
      return true
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
      return currentUserDetail.fullname
    end
  end
  
  def get_user_student
    if session[:user_id] != nil
      currentUser = User.find(session[:user_id])
      student = currentUser.people.student
      return student
    end
  end
  
  def get_user_administrator
    if session[:user_id] != nil
      currentUser = User.find(session[:user_id])
      admin = currentUser.people.administrator
      return admin
    end
  end

  def get_student_internships
    if check_session? && get_type_of_user == TYPE_STUDENT
      return People.find(session[:user_id]).student.internships      
    end
  end
  
  def get_not_review_yet   
    tempStudent = Student.new
    if !(internships = get_student_internships).nil?
      internships.each do |internship|
        logger.debug internship.enddate - internship.startdate
        if(internship.enddate - internship.startdate) >= REQUIRED_DURATION_FOR_REVIEW and internship.isreview == false
          tempStudent.internships << internship
        end
      end
    end
    return tempStudent.internships
  end
  
  def get_review_done         
    tempStudent = Student.new
    if !(internships = get_student_internships).nil?
      internships.each do |internship|          
        if internship.isreview
          tempStudent.internships << internship
        end
      end
    end
    return tempStudent.internships
  end    
  
  def get_content_digest(body)
    Array words = body.split(" ")
    i = 0
    digest = ""
    words.each do |word|
      if i<NUMBER_OF_WORDS_FOR_DIGEST
        digest << word+" "
        i = i+1
      elsif i==NUMBER_OF_WORDS_FOR_DIGEST
        digest << " ..."
        i = i+1
      else
        break
      end
    end
    return digest
  end
  
end
