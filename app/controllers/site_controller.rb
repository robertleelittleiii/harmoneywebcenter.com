

class SiteController < ApplicationController

  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])

  def index
    
    session[:mainnav_status] = false
    @page = Page.find_by_title("Home")||"'Home' not found."
    @menu = @page.menu rescue nil
        
    session[:parent_menu_id] = @menu.id rescue session[:parent_menu_id] = 0
    
        
    puts("parent menu id:", session[:parent_menu_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  def show_page
    session[:mainnav_status] = false
    @page = Page.find(params[:id])
    @menu = @page.menu
    
    if params[:top_menu] 
      session[:parent_menu_id] = @menu.id rescue 0
    end
        
    puts("parent menu id:", session[:parent_menu_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end

  end
  
  def show_properties
    @page_name = "Our Listings"
    @properties = Property.find_properties(params[:realtor_id])
      
    
    puts("count of properties: #{@properties.count}")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end
  
  def show_prop_slideshow
    @properties = Property.find_properties(params[:realtor_id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

   def show_prop_slideshow_partial
        @properties = Property.find_properties(params[:realtor_id])
      render :partial => "show_prop_slideshow", :format=>"html"
  end
  
  protected

  def authorize
  end

  def authenticate
  end
end
