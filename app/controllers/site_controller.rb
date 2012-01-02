class SiteController < ApplicationController

  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])

  def index
    
       session[:mainnav_status] = false

    @page = Page.find_by_title("Home")||"'Home' not found."
  end

  def show_page
       session[:mainnav_status] = false
    @page = Page.find(params[:id])
    @menu = Menu.find_by_page_id(@page.id)
    
    if params[:top_menu] 
      session[:parent_menu_id] = @menu.id rescue 0
    end
    
    puts("parent menu id:", session[:parent_menu_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end

  end

  protected

  def authorize
  end

   def authenticate
  end
end
