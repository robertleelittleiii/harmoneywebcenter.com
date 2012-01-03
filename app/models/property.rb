class Property  < SuperModel::Base
  
  include SuperModel::RandomID
   attributes :name, :mls_id, :price, :location, :picture_url
  # validates_presence_of :name

  
 
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
