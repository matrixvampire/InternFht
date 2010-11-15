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
    @controller_list = Array.new
    @model_list = Array.new
    @views_list = Array.new
    @sourcecontent = ""
    if params[:type] == "controller"
      file = File.new("#{RAILS_ROOT}/app/controllers/"+params[:name]+".rb","r")
      @sourceController = ""
      while(line = file.gets)
        @sourceController = @sourceController.concat(line)
      end
      file.close
      @sourcecontent = @sourceController
    elsif params[:type] == "model"
      file = File.new("#{RAILS_ROOT}/app/models/"+params[:name]+".rb","r")
      @sourcemodel = ""
      while(line = file.gets)
        @sourcemodel = @sourcemodel.concat(line)
      end
      file.close
      @sourcecontent = @sourcemodel
    end     
    controllers = Dir.new("#{RAILS_ROOT}/app/controllers").entries
    controllers.each do |controller|
      if controller =~ /_controller/ 
        cont = controller.camelize.gsub(".rb","")
        @controller_list << controller.gsub(".rb","")
         (eval("#{cont}.new.methods") - 
        ApplicationController.methods - 
        Object.methods -  
        ApplicationController.new.methods).sort.each {|met| 
          puts "\t#{met}"
        }        
      end  
    end
    models = Dir.new("#{RAILS_ROOT}/app/models").entries
    models.each do |model|
      if model.include?(".rb")
        @model_list << model.gsub(".rb","")
      end
    end    
  end
  #  def viewsource
  #   
  #    @sourceController = "";
  #    dir = "./app/controllers/"
  #    contains = Dir.new(dir).entries
  #    contains.length.times do |i|  
  #      if contains[i].include?(".rb")
  #        @sourceController = @sourceController + "\n\n ********* " + contains[i] + " *********\n\n"
  #        file = File.new("./app/controllers/"+contains[i],"r");
  #        
  #        while(line = file.gets)
  #          @sourceController = @sourceController.concat(line);
  #        end
  #        file.close;
  #      end
  #    end
  #  
  #    @sourceModel = "";
  #    dir = "./app/models/"
  #    contains = Dir.new(dir).entries
  #    contains.length.times do |i|  
  #      if contains[i].include?(".rb")
  #        @sourceModel = @sourceModel + "\n\n ********* " + contains[i] + " *********\n\n"
  #        file = File.new("./app/models/"+contains[i],"r");
  #        
  #        while(line = file.gets)
  #          @sourceModel = @sourceModel.concat(line);
  #        end
  #        file.close;
  #      end
  #    end
  #    
  ##    file = File.new("./app/controllers/user_controller.rb","r");
  ##    @sourceController = "";
  ##    while(line = file.gets)
  ##      @sourceController = @sourceController.concat(line);
  ##    end
  ##    file.close;
  #    
  #    @sourceHtmlErb = "";
  #    dir = "./app/views/user/"
  #    contains = Dir.new(dir).entries
  #    contains.length.times do |i|  
  #      if contains[i].include?(".html.erb") or contains[i].include?(".rxml")
  #        @sourceHtmlErb = @sourceHtmlErb + "\n\n ********* " + contains[i] + " *********\n\n"
  #        file = File.new("./app/views/user/"+contains[i],"r");
  #        
  #        while(line = file.gets)
  #          @sourceHtmlErb = @sourceHtmlErb.concat(line);
  #        end
  #        file.close;
  #      end
  #    end
  #  end
  
end
