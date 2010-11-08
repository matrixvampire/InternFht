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
  
  def viewsource
    
    @sourceController = "";
    dir = "./app/controllers/"
    contains = Dir.new(dir).entries
    contains.length.times do |i|  
      if contains[i].include?(".rb")
        @sourceController = @sourceController + "\n\n ********* " + contains[i] + " *********\n\n"
        file = File.new("./app/controllers/"+contains[i],"r");
        
        while(line = file.gets)
          @sourceController = @sourceController.concat(line);
        end
        file.close;
      end
    end
  
    @sourceModel = "";
    dir = "./app/models/"
    contains = Dir.new(dir).entries
    contains.length.times do |i|  
      if contains[i].include?(".rb")
        @sourceModel = @sourceModel + "\n\n ********* " + contains[i] + " *********\n\n"
        file = File.new("./app/models/"+contains[i],"r");
        
        while(line = file.gets)
          @sourceModel = @sourceModel.concat(line);
        end
        file.close;
      end
    end
    
#    file = File.new("./app/controllers/user_controller.rb","r");
#    @sourceController = "";
#    while(line = file.gets)
#      @sourceController = @sourceController.concat(line);
#    end
#    file.close;
    
    @sourceHtmlErb = "";
    dir = "./app/views/user/"
    contains = Dir.new(dir).entries
    contains.length.times do |i|  
      if contains[i].include?(".html.erb") or contains[i].include?(".rxml")
        @sourceHtmlErb = @sourceHtmlErb + "\n\n ********* " + contains[i] + " *********\n\n"
        file = File.new("./app/views/user/"+contains[i],"r");
        
        while(line = file.gets)
          @sourceHtmlErb = @sourceHtmlErb.concat(line);
        end
        file.close;
      end
    end
  end
  
end
