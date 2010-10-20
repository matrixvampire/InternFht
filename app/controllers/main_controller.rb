class MainController < ApplicationController
  def index
    @title = "#{APPLICATION_NAME}"
    if logged_in?
      redirect_to :controller => :user, :action => :index
    end
  end
  
  def about
    @title = "About #{APPLICATION_NAME}"
  end
  
  def help
    @title = "Help #{APPLICATION_NAME}"
  end
  
end
