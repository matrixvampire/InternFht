class AdminController < ApplicationController
  
  def show_criteria
    @title = "Criteria"
    @criterias = EvaluationCriteria.find(:all, :order => :title)
    @criterias_count = @criterias.length    
  end
  
  def show_enquiry
    @title = "Enquiry"
    @enquiries = EvaluationEnquiry.find(:all, :order => :evaluation_criteria_id)
    @enquiries_count = @enquiries.length
  end
  
  def add_enquiry
    @title = "Add"
    @subtitle = "Enquiry"
    if logged_in?
      if is_admin?
        if request.post?
          if params[:enquiry]
            @enquiry = EvaluationEnquiry.new(params[:enquiry])            
            if @enquiry.save
              flash[:notice] = "Evaluation Enquiry created successfully !!!"              
            else
              flash[:error] = "Some Problem. Try later."
            end
            redirect_to :action => :show_enquiry
          end
        else
          @criterias = EvaluationCriteria.find(:all, :order => :title)
          @enquiry = EvaluationEnquiry.new
        end
      end
    end
  end
  
  def add_criteria
    @title = "Add"
    @subtitle = "Criteria"
    if logged_in?
      if is_admin?
        if request.post?
          if params[:criteria]
            @criteria = EvaluationCriteria.new(params[:criteria])            
            if @criteria.save
              flash[:notice] = "Evaluation Criteria created successfully !!!"              
            else
              flash[:error] = "Some Problem. Try later."
            end
            redirect_to :action => :show_criteria
          end
        else
          @criteria = EvaluationCriteria.new
        end
      end
    end
  end
  
  def edit_enquiry
    @title = "Edit"
    @subtitle = "Enquiry"
    @criterias = EvaluationCriteria.find(:all, :order => :title)
    if logged_in?
      if is_admin?        
        if params[:id]
          @enquiry = EvaluationEnquiry.find(params[:id])
        end
      end
    end
  end
  
  def update_enquiry
    if logged_in?
      if is_admin?
        if EvaluationEnquiry.update(params[:id], params[:enquiry])
          flash[:notice] = "Evaluation Enquiry updated successfully!!!"          
        else
          flash[:error] = "Some problem. Try it later"          
        end
        redirect_to :action => :show_enquiry
      end
    end
  end
  
  def edit_criteria
    @title = "Edit"
    @subtitle = "Criteria"    
    if logged_in?
      if is_admin?        
        if params[:id]
          @criteria = EvaluationCriteria.find(params[:id])
        end
      end
    end
  end
  
  def update_criteria
    if logged_in?
      if is_admin?
        if EvaluationCriteria.update(params[:id], params[:criteria])
          flash[:notice] = "Evaluation Criteria updated successfully!!!"          
        else
          flash[:error] = "Some problem. Try it later"          
        end
        redirect_to :action => :show_criteria
      end
    end
  end    
end
