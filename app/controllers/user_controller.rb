class UserController < ApplicationController
  
  ssl_required :login
  ssl_allowed :register
  
  before_filter :protect, :only => [:index, :register]
  
  def index
    @title = "Welcome"
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
          flash[:notice] = "User #{user.username} logged in!"
          redirect_to_forwarding_url
        else
          flash[:notice] = "Invalid User"
        end
      else
        flash[:notice] = "Invalid username/password combination"
      end
    end
  end
  
  def register
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
          user.isvalid = true;
          
          people = People.new
          people.firstname = params[:firstname].capitalize!
          people.middlename = params[:middlename].capitalize!
          people.lastname = params[:lastname].capitalize!
          people.nickname = params[:nickname].capitalize!
          people.emailaddress = params[:emailaddress].downcase!
          people.phonenumber = params[:phonenumber]
          people.mobilenumber = params[:mobilenumber]
          people.birthdate = params[:birthdate]
          people.gender = params[:gender]          
          people.user = user
          
          address = Address.new
          address.buildingnumber = params[:buildingnumber]
          address.streetname = params[:streetname].capitalize!
          address.city = params[:city].capitalize!
          address.state_province = params[:stateprovince].capitalize!
          address.country = params[:country]
          address.type = params[:addresstype].capitalize!
          
          if params[:usertype] == "Student"
            student = Student.new
            student.identificationcode = params[:identificationcode]
            student.people = people
            student.addresses << address
            
            if student.save
              flash[:notice] = "Student Profile created successfully!!!"
              redirect_to_forwarding_url
            else
              flash[:notice] = "Some problem. Try later."
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
              flash[:notice] = "Some problem. Try later."
            end
          end
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
  
  def param_posted?(attr)
    !params[attr].nil?
  end
  
end
