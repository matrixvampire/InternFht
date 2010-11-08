class EvalutationController < ApplicationController
  
  def index
    @title = "Evaluation"
    @subtitle = "#{APPLICATION_NAME}"
  end
  
  def criteria_list
    @title = "Criteria"
    @subtitle = "for evaluation"
  end
  
  def enquiry_list
    @title = "Enquiry"
    @subtitle = "for evaluation"
  end
  
end
