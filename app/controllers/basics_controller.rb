# Web Application Engineering - Group 4
# Problem Set - II
# basics_controller.rb

require 'rubygems'
require 'hpricot'
require 'net/http'
require 'uri'

class BasicsController < ApplicationController
  # Stores the list of hidden quotes ids
  @@hide_list = "0"
  # Help from Ruby Cookbook
  # Define function set_cookies to run before any thing else
  before_filter :set_cookies
  def set_cookies    
    if !cookies[:kill_list]
      cookies[:kill_list] = { :value => "0", 
        :expires => Time.now + 1.month }
    end
  end
  
  # http://www.google.com/recaptcha
  # http://code.google.com/apis/recaptcha/docs/display.html
  # http://code.google.com/apis/recaptcha/docs/verify.html

  # recaptcha - ReCaptcha helpers for Rails apps 
  # https://github.com/ambethia/recaptcha

  # Using reCaptcha in a Rails Application 
  # http://www.dreamincode.net/code/snippet1901.htm
  
  def quotations    
    if params[:quotation]
      @quotation = Quotation.new( params[:quotation] )     
      if @quotation.valid? && verify_recaptcha(@quotation) && @quotation.save
        flash[:notice] = 'Quotation was successfully created.'
        @quotation = Quotation.new
      end
    else      
      @quotation = Quotation.new
    end
    if params[:kill] == "none"
      cookies[:kill_list] = "0"
    end
    if params[:kill] == "one"
      @quote = Quotation.find(params[:id])    
      @@hide_list = cookies[:kill_list]    
      @@hide_list = "#{@@hide_list},#{@quote.id}"
      cookies[:kill_list] = @@hide_list
    end
    if params[:sort_by] == "date"
      @@hide_list = cookies[:kill_list]
      # Removes quotes which are in hidden list
      @quotations = Quotation.find( :all, :conditions => ["id NOT IN (?)", Array(@@hide_list.split(','))], :order => :created_at )
    else
      @@hide_list = cookies[:kill_list]
      # Removes quotes which are in hidden list
      @quotations = Quotation.find( :all, :conditions => ["id NOT IN (?)", Array(@@hide_list.split(','))], :order => :category )
    end    
    # Stores all distinct category list
    @categories = Quotation.find(:all, :select => 'DISTINCT category', :order => 'category')
  end
  
  # Help from http://railscasts.com/episodes/37-simple-search-form
  def search_quote
    if params[:kill] == "none"
      cookies[:kill_list] = "0"
    end
    if params[:kill] == "one"
      @quote = Quotation.find(params[:id])    
      @@hide_list = cookies[:kill_list]    
      @@hide_list = "#{@@hide_list},#{@quote.id}"
      cookies[:kill_list] = @@hide_list
    end
    @@hide_list = cookies[:kill_list]
    if params[:hint]
      session[:hint] = params[:hint]
      @hint = params[:hint]  
    else
      @hint = session[:hint]
    end
    # Help from http://paulsturgess.co.uk/articles/show/22-how-to-combine-multiple-conditions-in-a-find-statement-in-ruby-on-rails
    # to merge more than two conditions
    @quotes = Quotation.find(:all, :conditions => ["id NOT IN (?) and (LOWER(quote) LIKE ? or LOWER(author_name) LIKE ?)", 
                                                    Array(@@hide_list.split(',')), "%#{@hint.downcase}%", "%#{@hint.downcase}%"],
                                                    :order => 'quote ASC')
    
  end
  
  # Help from http://www.tutorialspoint.com/ruby-on-rails/rails-session-cookies.htm
  def kill_quoter
    @quote = Quotation.find(params[:id])    
    @@hide_list = cookies[:kill_list]    
    @@hide_list = "#{@@hide_list},#{@quote.id}"
    cookies[:kill_list] = @@hide_list
  end
  
  # Help from http://puneetitengineer.wordpress.com/2008/12/08/generate-xml-with-rails/
  def quotations_xml
    @xml = Builder::XmlMarkup.new
    @quotations = Quotation.find(:all)
    render :layout => false
  end
  
  # Help from http://railstips.org/blog/archives/2006/12/09/parsing-xml-with-hpricot/
  # Help from http://www.rubyinside.com/nethttp-cheat-sheet-2940.html
  # Help from http://ruby.about.com/od/networking/qt/twitterparse.htm
  def parsing_xml
    if params[:xmlurl]
      url = URI.parse(params[:xmlurl])
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      doc = Hpricot::XML(res.body)
       (doc/:onequote).each do |quote|
        quotation_id = quote.get_elements_by_tag_name('quotation_id').innerHTML.to_s
        insertion_date = quote.get_elements_by_tag_name('insertion_date').innerHTML.to_s
        author_name = quote.get_elements_by_tag_name('author_name').innerHTML.to_s
        category = quote.get_elements_by_tag_name('category').innerHTML.to_s
        quote = quote.get_elements_by_tag_name('quote').innerHTML.to_s
        
        stored_quote = Quotation.find(:all, :conditions => ["UPPER(author_name) = ? and UPPER(quote) = ? ","#{author_name.upcase}","#{quote.upcase}"])
        if stored_quote.empty?
          quotation = Quotation.new
          quotation.author_name = author_name
          quotation.category = category
          quotation.quote = quote
          quotation.save
          flash[:notice] = "#{quotation.quote} is added successfully!!!"
        end
        #      ['quotation_id', 'insertion_date', 'author_name', 'category', 'quote'].each do |el|
        #        puts "#{el}: #{quote.get_elements_by_tag_name(el).innerHTML}"
        #      end
      end    
    end
  end  
  
  def viewsource
    file = File.new("./app/controllers/basics_controller.rb","r");
    @sourceController = "";
    while(line = file.gets)
      @sourceController = @sourceController.concat(line);
    end
    file.close;
    
    @sourceHtmlErb = "";
    dir = "./app/views/basics/"
    contains = Dir.new(dir).entries
    contains.length.times do |i|  
      if contains[i].include?(".html.erb") or contains[i].include?(".rxml")
        @sourceHtmlErb = @sourceHtmlErb + "\n\n ********* " + contains[i] + " *********\n\n"
        file = File.new("./app/views/basics/"+contains[i],"r");
        
        while(line = file.gets)
          @sourceHtmlErb = @sourceHtmlErb.concat(line);
        end
        file.close;
      end
    end
  end 
end
