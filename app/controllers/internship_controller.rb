class InternshipController < ApplicationController
  
  before_filter :protect, :only => [:index, :create, :edit, :update]
  
  def index
    @title = "Internship"
    @internshiplist = Internship.find(:all, :order => :created_at);    
  end
  
  def create
    @title = "Internship"
    @subtitle = "Create"
    if is_admin?
      if request.post?
        if(params[:internship]) 
          @internship = Internship.new(params[:internship])
          if @internship.enddate < @internship.startdate
            flash[:error] = "End date cannot be less than startdate"
            redirect_to :action => :create
          end
          @internship.isreview = false
          if @internship.save
            flash[:notice] = "Internship information created successfully !!!"              
          else
            flash[:error] = "Some Problem. Try later."
          end
          redirect_to :action => :index
        end
      else
        @internship = Internship.new
        @studentlist = Student.find(:all, :order => :identificationcode)
        @sitelist = Site.find(:all, :order => :sitename)
      end
    else
      flash[:error] = "Restricted Area."
    end
  end
  
  def edit
    @title = "Internship"
    @subtitle = "Edit"
    if is_admin?      
      if(params[:id])
        @internship = Internship.find(params[:id])
        @studentlist = Student.find(:all, :order => :identificationcode)
        @sitelist = Site.find(:all, :order => :sitename)      
      end
    else
      flash[:error] = "Restricted Area."
    end    
  end
  
  def update
    if is_admin?
      if Internship.update(params[:id], params[:internship])
        flash[:notice] = "Internship information updated successfully !!!"          
      else
        flash[:error] = "Some problem. Try it later"          
      end
      redirect_to :action => :index
    else
      flash[:error] = "Restricted Area."
    end
  end
  
end
