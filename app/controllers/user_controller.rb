class UserController < ApplicationController
  
  ssl_required :login, :changepassword
  ssl_allowed :register, :editprofile
  
  before_filter :protect, :only => [:index, :register, :editprofile, :changepassword, :show]
  
  def index
    @title = "Welcome"    
  end
  
  def show
    @title = "Show"
    @peoples = Array.new
    
    #find all users in system
    @faculties = Faculty.find(:all, :order => :created_at)
    @no_faculties = @faculties.length
    @students = Student.find(:all, :order => :created_at)
    @no_students = @students.length
    
    if params[:showlist] == TYPE_FACULTY   
      @faculties.each do |f|
        @peoples << f.people
      end
    else
      @students.each do |s|
        @peoples << s.people
      end
    end
    if !params[:valid].nil?
      @people = People.find(params[:id])
      if params[:valid] == "true"
        @people.user.isvalid = true
      elsif params[:valid] == "false"
        @people.user.isvalid = false        
      end
      @people.user.save
    end
    if !params[:search].nil?
      @search = params[:search].strip.downcase
      @peoples = People.find(:all, :conditions => ["(LOWER(firstname) LIKE ? or LOWER(lastname) LIKE ?)", "%#{@search.downcase}%", "%#{@search.downcase}%"], :order => :firstname)
    end  
  end
  
  def login
    @title = "Log in"
    if request.get?
      @user = User.new
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_username( @user.username )
      if user && user.authenticate( params[:user][:password] )
        if user.isvalid
          user.login!(session)    
          user.logged_counter = (user.logged_counter!=nil ? user.logged_counter : 0)+1
          user.save
          flash[:notice] = "User #{user.username} logged in!"
          if is_admin?
            redirect_to_forwarding_url
          else
            redirect_to_individual_profile_url
          end
        else
          flash[:error] = "Invalid User"
        end
      else
        flash[:error] = "Invalid username/password combination"
      end
    end
  end
  
  def register
#    Depreciated
#    Need to be replaced according to studententry, facultyentry, siteentry
    @title = "Register"
    if logged_in?      
      if request.post?        
        if params[:usertype] == "Student" || params[:usertype] == "Faculty"
          # Assigning Value
          # Not much appropriate, Need new alternative
          user = User.new
          user.username = params[:username]
          user.password = params[:password]
          user.usertype = params[:usertype]
          user.isvalid = true
          
          people = People.new
          people.firstname = params[:firstname].capitalize
          people.middlename = params[:middlename].strip.capitalize
          people.lastname = params[:lastname].capitalize
          people.nickname = params[:nickname]
          people.emailaddress = params[:emailaddress].downcase
          people.phonenumber = params[:phonenumber]
          people.mobilenumber = params[:mobilenumber]
          people.birthdate = params[:birthdate]
          people.gender = params[:gender]          
          people.user = user
          
          address = Address.new
          address.buildingnumber = params[:buildingnumber]
          address.streetname = params[:streetname]
          address.city = params[:city]
          address.state_province = params[:stateprovince]
          address.country = params[:country]
          address.addresstype = params[:addresstype]
          
          if params[:usertype] == "Student"
            student = Student.new
            student.identificationcode = params[:identificationcode]
            student.people = people
            student.addresses << address
            
            if student.save
              flash[:notice] = "Student Profile created successfully!!!"
              redirect_to_forwarding_url
            else
              flash[:error] = "Some problem. Try later."
            end
          end
          if params[:usertype] == "Faculty"
            faculty = Faculty.new
            faculty.identificationcode = params[:identificationcode]
            faculty.people = people
            faculty.addresses << address
            
            if faculty.save
              flash[:notice] = "Faculty Profile created successfully!!!"
              redirect_to_forwarding_url
            else
              flash[:error] = "Some problem. Try later."
            end
          end
        end          
      end
    end
  end    
  
  def studententry
    @title = "Student Registration"
    if logged_in?      
      if request.post?       
        if params[:student]
          @student = Student.new(params[:student])
          @student.people.user.usertype = TYPE_STUDENT
          @student.people.user.isvalid = true
          #      Just outputting the values in console to debug
          logger.debug "Student : #{@student.attributes.inspect}"
          logger.debug "People : #{@student.people.attributes.inspect}"
          logger.debug "User : #{@student.people.user.attributes.inspect}"
          @student.addresses.each do |address|
            logger.debug "Address : #{address.attributes.inspect}"
          end      
          # Call save method
          # Check whether all the required tables been hit successfully
          if @student.save
            flash[:notice] = "Student Profile created successfully!!!"
            redirect_to_forwarding_url
          else
            flash[:error] = "Some problem. Try later."
          end
        else
          @student = Student.new
          @student.people = People.new
          @student.people.user = User.new
          #      Address entries should be make dynamic
          @student.addresses << Address.new
          @student.addresses << Address.new
        end    
      end
    end
  end
  
  
  def facultyentry
    #    same as studententry, difference is :faculty
  end
  
  def siteentry
    #    same as studententry
    #    dynamically creation of multiple entries for people
    
  end
  
  def editprofile
    @title = "Edit Profile"
    if logged_in?      
      if request.post? #...Edit
        people = People.find_by_user_id(session[:user_id])
        people.firstname = params[:firstname].strip
        people.middlename = params[:middlename].strip
        people.lastname = params[:lastname].strip
        people.nickname = params[:nickname].strip
        people.emailaddress = params[:emailaddress].strip.downcase
        people.phonenumber = params[:phonenumber].strip
        people.mobilenumber = params[:mobilenumber].strip
        people.gender = params[:gender].strip
        people.birthdate = params[:birthdate].strip
        people.faxnumber = params[:faxnumber].strip
        people.homepage = params[:homepage].strip
        
        if get_type_of_user == TYPE_STUDENT
          address = people.student.addresses.first
        elsif get_type_of_user == TYPE_FACULTY
          address = people.faculty.addresses.first
        elsif get_type_of_user == TYPE_ADMINISTRATOR
          address = people.administrator.addresses.first
        end
        
        address.addresstype = params[:address_type].strip
        address.buildingnumber = params[:buildingnumber].strip
        address.streetname = params[:streetname].strip
        address.city = params[:city].strip
        address.state_province = params[:state_province].strip
        address.zippostal_code = params[:zippostal_code].strip
        address.country = params[:country].strip
        
        
        ActiveRecord::Base.transaction do
          if address.save and people.save
            flash[:notice] = "Profile is edited successfully!!!"
            redirect_to :controller => :user, :action => :editprofile
          else
            flash[:error] = "Some error occurs, process is not successful!!!"
            redirect_to :controller => :user, :action => :editprofile
            raise ActiveRecord::Rollback
          end 
        end
        
      else #...Search
        @people = People.find_by_user_id(session[:user_id])
        # Assume that people has just one address
        if get_type_of_user == TYPE_STUDENT
          @address = @people.student.addresses.first
        elsif get_type_of_user == TYPE_FACULTY
          @address = @people.faculty.addresses.first
        elsif get_type_of_user == TYPE_ADMINISTRATOR
          @address = @people.administrator.addresses.first
        end
        
        if @address.nil?
          @address = Address.new      
        end
      end
    end
  end
  
  def changepassword
    @title = "Change Password"
    if logged_in?      
      if request.post? #...Edit
        if params[:new_password] != params[:confirm_password]
          flash[:error] = "Your new password did not match!!!"
          redirect_to :controller => :user, :action => :changepassword
        else  
          user = User.find(session[:user_id])
          if user && user.authenticate( params[:old_password] )
            user.password = params[:new_password]
            if user.save
              flash[:notice] = "Changed password successfully"
              redirect_to_forwarding_url
            else
              flash[:error] = "Some error occurs, process is not successful!!!"
              redirect_to :controller => :user, :action => :changepassword
            end
          else
            flash[:error] = "Entered wrong password!!"
            redirect_to :controller => :user, :action => :changepassword
          end
        end
        
      else #...Search
        
      end
    end
  end
  
  def forgetpassword
    @title = "Forget Password"
    if request.post? #...Edit
      user = User.find_by_username(params[:username])
      if user == nil
        flash[:error] = "User "+params[:username]+" does not exist!!"
        redirect_to :controller => :user, :action => :forgetpassword
      else
        user.validation_code = Digest::SHA1.hexdigest("--#{Time.now.to_s}----")[0,15]
        user.validity_period = Time.now + 7.days
        if user.save
          smtp_result = Verifier.deliver_verify_email(user, user.validation_code, User.find(user.id).validity_period) 
          flash[:notice] = "An email has been sent to user : "+params[:username]
          redirect_to :controller => :user, :action => :forgetpassword
        else
          flash[:error] = "Some problem occurs, process is not successful!!!"
          redirect_to :controller => :user, :action => :forgetpassword
        end
      end
    end
  end
  
  def createnewpassword
    @title = "Create New Password"
    if request.post? #...Edit
      user = User.find_by_username(params[:username])
      if user == nil
        flash[:error] = "User "+params[:username]+" does not exist!!"
        redirect_to :controller => :user, :action => :createnewpassword
      else #user exists
        if user.validation_code!=nil and (user.validation_code==params[:validation_code]) #code is match
          if Time.now > user.validity_period
            flash[:error] = "Your validation code in out of date, please get a new one!!!"
            redirect_to :controller => :user, :action => :forgetpassword
          else
            if params[:new_password] != params[:confirm_password] #two new password boxes is not match 
              flash[:error] = "Your new password did not match!!!"
              redirect_to :controller => :user, :action => :createnewpassword
            else  
              user.password = params[:new_password]
              user.validation_code = nil
              user.validity_period =nil
              if user.save
                flash[:notice] = "Password has been created!!!"
                redirect_to :controller => :user, :action => :login
              else
                flash[:error] = "Some error occurs, process is not successful!!!"
                redirect_to :controller => :user, :action => :createnewpassword
              end
            end
          end
        else
          flash[:error] = "Your validation code is wrong"
          redirect_to :controller => :user, :action => :createnewpassword
        end
      end
    end
  end
  
  private
  
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end
  
  def redirect_to_individual_profile_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      if get_type_of_user == TYPE_STUDENT
        redirect_to :controller => :student,  :action => :profile
      elsif get_type_of_user == TYPE_FACULTY
        redirect_to :controller => :faculty, :action => :profile
      end
    end
  end
  
  def param_posted?(attr)
    !params[attr].nil?
  end
  
end
