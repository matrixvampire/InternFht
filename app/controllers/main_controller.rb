class MainController < ApplicationController
  def index
    @title = "Home"
    @subtitle = "#{APPLICATION_NAME}"
    if logged_in?
      redirect_to :controller => :user, :action => :index
    end
  end
  
  def about
    @title = "About"
    @subtitle = "#{APPLICATION_NAME}"
  end
  
  def faq
    @title = "FAQ"
    @subtitle = "#{APPLICATION_NAME}"
  end
  
  def contact
    @title = "Contact"
    @subtitle = "#{APPLICATION_NAME}"
  end
  
  def sitemap
    @title = "Site Map"
    @subtitle = "#{APPLICATION_NAME}"
  end
  
end
