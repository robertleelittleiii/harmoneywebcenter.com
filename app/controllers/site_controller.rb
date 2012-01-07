

class SiteController < ApplicationController

  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])

  def index
    
    session[:mainnav_status] = false
    @page = Page.find_by_title("Home")||"'Home' not found."
    @menu = @page.menu
        
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
    
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'supermodel'
    @page_name = "Our Listings"
    realtor_id=params[:realtor_id]
    for category in (1..7) do
      url = "http://www.monmouthoceanmls.com/(tdp3yamo1d0hu1rkv2jelhqn)/propertyResults.aspx?DTP=_parent&ShowNav=&CurrentRecord=&tex_mls_acct=&category=#{category}&agent=#{realtor_id}"
      doc = Nokogiri::HTML(open(url))
      #puts doc.at_css("title").text
      save=true
      doc.css(".resultItemContainer").each do |item|
        save=true
        title= item.at_css(".resultsPrice b").text rescue save=false
        if Property.find_by_title(title).blank? then
          a = Property.new
          a.title = title
          a.price = item.at_css(".resultsPrice:nth-child(3) font").text[/\$[0-9\.\,]+/] rescue "nothing"
          a.municipality = item.at_css(".resultsDetailsTable tr:nth-child(2) td:nth-child(2)").text rescue "nothing"
          a.bedrooms = item.at_css("#contentCell tr:nth-child(3) td:nth-child(2)").text rescue "nothing"
          a.fullbaths = item.at_css("tr:nth-child(4) td:nth-child(2)").text rescue ""
          a.halfbaths = item.at_css("tr:nth-child(4) td:nth-child(4)").text rescue ""
          a.acreage = item.at_css("tr:nth-child(5) td:nth-child(2)").text rescue ""
          a.squarefeet = item.at_css(".resultsDetailsTable tr:nth-child(2) td:nth-child(4)").text rescue ""
          a.yearbuilt = item.at_css("#contentCell tr:nth-child(3) td:nth-child(4)").text rescue ""
          a.exterior = item.at_css("tr:nth-child(6) td:nth-child(2)").text rescue ""
        
         
        
          photo = item.at_css(".resultsPhoto") rescue "nothing"
          a.photo_url = photo[:src] rescue "nothing"
          if save then a.save end
      
          puts "#{a.title} - #{a.price}- #{a.municipality} #{a.photo[:alt]} #{a.photo[:src]}" rescue "nothing"
          #puts item.at_css(".prodLink")[:href]
        end
      end
    end
    
    @properties = Property.all
    
    puts("count of properties: #{@properties.count}")
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
