class Property  < SuperModel::Base
  
  include SuperModel::RandomID
   attributes :name, :mls_id, :price, :location, :picture_url
  # validates_presence_of :name

  
  def self.find_properties(realtor_id)
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'supermodel'
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
          a.realtor_id = realtor_id
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
    
    return (Property.find_all_by_realtor_id(realtor_id))
  end
 
  #  def initialize(attributes = {})
  #    attributes.each do |name, value|
  #      send("#{name}=", value)
  #    end
  #  end
  #  
  #  def persisted?
  #    false
  #  end

end
